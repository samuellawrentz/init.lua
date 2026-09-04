-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- All keymaps live in lua/config/whichkey.lua; plugins here are loaded lazily
-- by cmd/event, or on first require() from a keymap callback.
require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("config.whichkey").setup() end,
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        treesitter = false,
        preview = { layout = 'vertical', vertical = 'up:60%', default = 'bat' },
      },
      previewers = { bat = { args = "--style=numbers,changes --color always", theme = 'Coldark-Dark' } },
      files = { prompt = 'Files❯ ', git_icons = true, path_shorten = 1 },
      grep = { prompt = 'Rg❯ ' },
      buffers = { prompt = 'Buffers❯ ', sort_mru = true },
      git = { files = { prompt = 'GitFiles❯ ' } },
      lsp = { prompt_postfix = '❯ ', cwd_only = false, async_or_timeout = 5000, ui_select = true, symbol_style = 1 },
    },
  },

  -- Colorschemes: lazy.nvim loads the plugin on :colorscheme (see samsden.theme)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      disable_background = true,
      dim_inactive_windows = true,
      styles = { bold = true, italic = true },
      highlight_groups = { StatusLine = { fg = "love", bg = "love", blend = 15 } },
    },
  },
  { "folke/tokyonight.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },

  -- LSP: mason-lspconfig v2 calls vim.lsp.enable() for every installed server
  { "williamboman/mason.nvim", cmd = "Mason", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    opts = { ensure_installed = { "ts_ls", "gopls" } },
    config = function(_, opts)
      vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = { ensure_installed = { "biome" } },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "onsails/lspkind.nvim", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = { { name = "supermaven" }, { name = "nvim_lsp" } },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = require("lspkind").cmp_format({ maxwidth = 50, show_labelDetails = true, ellipsis_char = "..." }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
      })
      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    cmd = { "SupermavenUseFree", "SupermavenUsePro" },
    opts = { keymaps = { accept_word = "<c-g>" } },
  },

  -- Linting / formatting (biome)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local biome = { "biomejs" }
      lint.linters_by_ft = {
        javascript = biome, typescript = biome, javascriptreact = biome, typescriptreact = biome,
        json = biome, jsonc = biome,
      }
      local grp = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = grp,
        callback = function() lint.try_lint() end,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = grp,
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc" },
        callback = function(ev)
          local content = table.concat(vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false), "\n")
          local result = vim.fn.system("biome check --write --stdin-file-path " .. vim.fn.shellescape(ev.file), content)
          if vim.v.shell_error == 0 and result ~= content then
            vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, vim.split(result:gsub("\n$", ""), "\n"))
          end
        end,
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      sort_by = "case_sensitive",
      sync_root_with_cwd = true,
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "<Esc>", api.tree.close, { desc = "nvim-tree: Close", buffer = bufnr, nowait = true })
      end,
      renderer = { group_empty = true, highlight_opened_files = 'icon', root_folder_label = false },
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local cols, lines = vim.o.columns, vim.o.lines - vim.o.cmdheight
            local w, h = math.floor(cols * 0.5), math.floor(lines * 0.8)
            return {
              border = "rounded",
              relative = "editor",
              row = (vim.o.lines - h) / 2 - vim.o.cmdheight,
              col = (cols - w) / 2,
              width = w,
              height = h,
              title = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " ",
              title_pos = "center",
            }
          end,
        },
      },
      update_focused_file = { enable = true },
      live_filter = { always_show_folders = false },
    },
  },

  { "ThePrimeagen/harpoon", branch = "harpoon2", lazy = true, dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("harpoon"):setup() end },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "arkav/lualine-lsp-progress" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
      },
      sections = {},
      tabline = {
        lualine_a = {},
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = { 'lsp_progress' },
        lualine_x = {},
        lualine_y = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_lsp' } } },
        lualine_z = { 'mode' },
      },
    },
  },

  -- Treesitter (main branch: highlight/indent are started per-buffer, no configs module)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "query", "javascript", "typescript", "tsx",
        "html", "css", "json", "yaml", "toml", "markdown", "markdown_inline",
        "go", "fish", "php",
      })
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("samsden-treesitter", { clear = true }),
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  { "hedyhli/outline.nvim", cmd = { "Outline", "OutlineOpen" }, opts = {} },

  {
    "pwntester/octo.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua", "nvim-tree/nvim-web-devicons" },
    cmd = "Octo",
    opts = { picker = "fzf-lua" },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = { "BufReadPost", "BufNewFile" },
    opts = { provider_selector = function() return { 'treesitter', 'indent' } end },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      attach_to_untracked = true,
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      update_debounce = 500,
      max_file_length = 10000,
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end
        map("n", "]c", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[c", function() gs.nav_hunk("prev") end, "Prev hunk")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
        map("n", "<leader>dd", gs.diffthis, "Diff file vs HEAD")
        map("n", "<leader>dD", function() gs.diffthis("~1") end, "Diff file vs HEAD~1")
      end,
    },
  },

  -- Diffview (auto-infers repo from current buffer — works in multi-repo workspaces)
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" } },

  { "tpope/vim-commentary", keys = { "gc", "gcc" } },
  { "almo7aya/openingh.nvim", cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" } },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = { scope = { show_start = false, show_end = false } },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true, opts = { default = true, strict = true } },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { lua = { 'string' }, javascript = { 'template_string' }, java = false },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
    opts = {},
  },

  { "folke/zen-mode.nvim", cmd = "ZenMode", opts = {} },

  {
    "gbprod/yanky.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    event = "VeryLazy",
    opts = {
      ring = { history_length = 50, sync_with_numbered_registers = false, ignore_registers = { "_" } },
      highlight = { timer = 200, on_yank = true, on_put = true },
      picker = { fzf_lua = { use_default_mappings = true } },
    },
  },

  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
  { "cameronr/hbac.nvim", event = "VeryLazy", opts = { threshold = 25 } },
  { "leath-dub/snipe.nvim", lazy = true, opts = {} },
}, {
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
