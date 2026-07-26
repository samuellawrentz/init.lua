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

-- Setup lazy.nvim
require("lazy").setup({
  -- Core dependencies
  "nvim-lua/plenary.nvim",
  
  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.whichkey").setup()
    end,
  },

  -- FZF
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
      { "<leader>fg", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
    },
  },

  -- Colorschemes (all loaded eagerly so picker can switch instantly)
  { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("samsden.theme").apply()
      vim.keymap.set("n", "<leader>tt", function() require("samsden.theme").pick() end, { desc = "Theme picker" })
    end,
  },

  -- LSP Configuration
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "onsails/lspkind.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    },
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Add to Harpoon" },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
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

-- Outline symbols
    {
      "hedyhli/outline.nvim",
      lazy = true,
      cmd = { "Outline", "OutlineOpen" },
      keys = { -- Example mapping to toggle outline
        { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
      },
    },

  -- GitHub Integration
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
  },

  -- Folding
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(buf)
          local gs = require("gitsigns")
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
          end
          map("]c", function() gs.nav_hunk("next") end, "Next hunk")
          map("[c", function() gs.nav_hunk("prev") end, "Prev hunk")
          map("<leader>hp", gs.preview_hunk, "Preview hunk")
          map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
          map("<leader>hr", gs.reset_hunk, "Reset hunk")
          map("<leader>dd", gs.diffthis, "Diff file vs HEAD")
          map("<leader>dD", function() gs.diffthis("~1") end, "Diff file vs HEAD~1")
        end,
      })
    end,
  },

  -- Diffview (auto-infers repo from current buffer — works in multi-repo workspaces)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diff: open repo view" },
      { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff: file history" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diff: close" },
      { "<leader>dw", function() require("samsden.workspace-diff").pick() end, desc = "Diff: workspace (all repos)" },
    },
  },

  -- Commentary
  { "tpope/vim-commentary", keys = { "gc", "gcc" } },

  -- GitHub Integration
  { "almo7aya/openingh.nvim", cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" } },

  -- Indent Blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- LSP Progress
  { "arkav/lualine-lsp-progress" },

  -- Minimap
  { "gorbit99/codewindow.nvim", cmd = { "Minimap", "MinimapToggle" } },


  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Auto Tag
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },

  -- Zen Mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
  },

  -- Yanky
  {
    "gbprod/yanky.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    event = "VeryLazy",
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Buffer Management
  {
    "cameronr/hbac.nvim",
    event = "VeryLazy",
    config = function()
      require("hbac").setup({})
    end,
  },

  -- Snipe
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "gb", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" },
    },
    config = function()
      require("snipe").setup()
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Copilot
{
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  cmd = { "SupermavenUseFree", "SupermavenUsePro" },
  config = function()
    require("supermaven-nvim").setup({
        keymaps = {
            -- Accept word
            accept_word ="<c-g>"
        }
    })
  end,
},
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
