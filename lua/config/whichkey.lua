local M = {}

-- Plugins are required inside callbacks so lazy.nvim loads them on first use.
local function fzf(fn, ...)
    local args = { ... }
    return function() require("fzf-lua")[fn](unpack(args)) end
end

local function file_picker()
    vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
    return vim.v.shell_error == 0 and "git_files" or "files"
end

function M.setup()
    require("which-key").add({
        -- Buffer management
        { "<leader>b", group = "Buffer" },
        { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>", desc = "Delete all buffers" },
        { "<leader>bc", "<Cmd>bd!<Cr>", desc = "Close current buffer" },
        { "<leader>q", "<cmd>qa!<CR>", desc = "Quit" },

        -- Utils/Tools
        { "<leader>z", group = "Utils" },
        { "<leader>zS", "<cmd>Lazy<cr>", desc = "Lazy Status" },
        { "<leader>zc", "<cmd>Lazy clean<cr>", desc = "Lazy Clean" },
        { "<leader>zi", "<cmd>Lazy install<cr>", desc = "Lazy Install" },
        { "<leader>zu", "<cmd>Lazy update<cr>", desc = "Lazy Update" },
        { "<leader>zm", "<cmd>Mason<cr>", desc = "Open Mason" },
        { "<leader>zz", function() require("zen-mode").toggle({ window = { width = .85 } }) end, desc = "Zen mode" },

        -- Find/Files
        { "<leader>f", group = "Find/Files" },
        { "<leader>ff", fzf("live_grep"), desc = "Live grep" },
        { "<leader>fg", fzf("grep_cword"), desc = "Grep word under cursor" },
        { "<leader>fb", fzf("buffers"), desc = "Find buffers" },
        { "<leader>fG", fzf("resume"), desc = "Resume last search" },
        { "<leader>fh", fzf("help_tags"), desc = "Help tags" },
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
        { "tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
        { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },

        -- LSP
        { "<leader>l", group = "LSP" },
        { "<leader>lw", fzf("lsp_live_workspace_symbols"), desc = "Workspace symbols" },
        { "<leader>lk", vim.diagnostic.open_float, desc = "Open diagnostic float" },
        { "<leader>ld", fzf("diagnostics_document"), desc = "Buffer diagnostics" },
        { "<leader>ls", fzf("lsp_document_symbols"), desc = "Document symbols" },
        { "<leader>lt", fzf("lsp_typedefs"), desc = "Type definitions" },
        { "<leader>lo", fzf("lsp_outgoing_calls"), desc = "Outgoing calls" },
        { "<leader>li", fzf("lsp_incoming_calls"), desc = "Incoming calls" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename symbol" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code actions" },
        { "<leader>lx", function()
            local on = not vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = on, underline = on })
        end, desc = "Toggle diagnostic virtual text" },
        { "<leader>lf", function()
            vim.cmd('!git diff --name-only HEAD | xargs -I {} biome lint {} --fix --unsafe')
            vim.cmd('edit!')
        end, desc = "Biome lint all changed files" },
        { "gd", fzf("lsp_definitions"), desc = "Go to definition" },
        { "gr", fzf("lsp_references"), desc = "Go to references" },
        { "gi", fzf("lsp_implementations"), desc = "Go to implementations" },
        { "K", function() vim.lsp.buf.hover({ border = "single", max_height = 25, max_width = 120 }) end, desc = "Hover documentation" },

        -- GitHub
        { "<leader>g", group = "Open in GitHub" },
        { "<leader>gr", ":OpenInGHRepo <CR>", desc = "Open repo in GitHub" },
        { "<leader>gf", ":OpenInGHFile <CR>", desc = "Open file in GitHub", mode = { "n", "v" } },

        -- Harpoon
        { "<leader>a", function() require("harpoon"):list():add() end, desc = "Add to Harpoon" },
        { "<C-e>", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Toggle Harpoon menu" },
        { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
        { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
        { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
        { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },

        -- Yanky
        { "<leader>p", function() require("yanky.picker").actions.put("p") end, desc = "Open Yank History" },
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
        { "<c-y>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank history entry" },
        { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Next yank history entry" },
        { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
        { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },

        -- Theme / Diff / Hunks
        { "<leader>t", group = "Theme" },
        { "<leader>tt", function() require("samsden.theme").pick() end, desc = "Theme picker" },
        { "<leader>d", group = "Diff" },
        { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diff: open repo view" },
        { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff: file history" },
        { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diff: close" },
        { "<leader>dw", function() require("samsden.workspace-diff").pick() end, desc = "Diff: workspace (all repos)" },
        { "<leader>h", group = "Hunks" },

        -- Misc
        { "<leader>so", "<cmd>so<cr>", desc = "Source file" },
        { "<leader>r", ":%s/", desc = "Find and replace" },
        { "<leader>/", fzf("blines"), desc = "Fuzzy search current buffer" },

        -- Navigation and movement
        { "jk", "<ESC>", mode = "i", desc = "Exit insert mode" },
        { "\\", "<C-w>w", desc = "Switch window" },
        { ",", "<C-w>", desc = "Window command prefix" },
        { "U", "<C-r>", desc = "Redo" },
        { "H", "^", desc = "Go to line start" },
        { "L", "$", desc = "Go to line end" },
        { "n", "nzz", desc = "Next search result (centered)" },
        { "N", "Nzz", desc = "Previous search result (centered)" },
        { "k", "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move up (display lines)" },
        { "j", "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move down (display lines)" },

        -- Visual mode
        { "<", "<gv", mode = "v", desc = "Indent left and reselect" },
        { ">", ">gv", mode = "v", desc = "Indent right and reselect" },
        { "K", ":move '<-2<CR>gv-gv", mode = "x", desc = "Move selection up" },
        { "J", ":move '>+1<CR>gv-gv", mode = "x", desc = "Move selection down" },

        -- Text objects and editing
        { "cw", '"_ciw', desc = "Change word (no yank)" },
        { "dw", '"_diw', desc = "Delete word (no yank)" },
        { "vw", "viw", desc = "Select word" },
        { "vC", 'vi"', desc = "Select inside double quotes" },
        { "vb", "vib", desc = "Select inside parentheses" },
        { "vc", "vi'", desc = "Select inside single quotes" },
        { "vB", "viB", desc = "Select inside braces" },
        { "dB", "diB", desc = "Delete inside braces" },
        { "db", "dib", desc = "Delete inside parentheses" },
        { "dc", "di'", desc = "Delete inside single quotes" },
        { "dC", 'di"', desc = "Delete inside double quotes" },
        { "cB", "ciB", desc = "Change inside braces" },
        { "cb", "cib", desc = "Change inside parentheses" },
        { "cc", '"_ci\'', desc = "Change inside single quotes (no yank)" },
        { "cC", '"_ci"', desc = "Change inside double quotes (no yank)" },
        { "x", '"_x', desc = "Delete character (no yank)" },
        { "S", '"_S', desc = "Substitute line (no yank)" },
        { "s", '"_s', desc = "Substitute character (no yank)" },
        { "<cr>", '"_ciw', desc = "Change word (no yank)" },

        -- Control mappings
        { "<C-s>", "<cmd>update!<CR><ESC>", mode = { "n", "i" }, desc = "Save file" },
        { "<C-q>", "<cmd>wa<CR><ESC>", mode = { "n", "i" }, desc = "Save all files" },
        { "<C-j>", "10j", desc = "Jump down 10 lines" },
        { "<C-k>", "10k", desc = "Jump up 10 lines" },
        { "<C-d>", "<C-d>zz", desc = "Half page down (centered)" },
        { "<C-u>", "<C-u>zz", desc = "Half page up (centered)" },
        { "<C-p>", function() require("fzf-lua").combine({ pickers = "buffers;" .. file_picker() }) end, desc = "Find files" },
        { "<C-r>", "<C-^>", desc = "Switch to alternate buffer" },
        { "<C-f>", fzf("buffers"), desc = "Find buffers" },

        -- Arrow keys for resizing
        { "<Left>", ":vertical resize +1<CR>", desc = "Increase window width" },
        { "<Right>", ":vertical resize -1<CR>", desc = "Decrease window width" },
        { "<Up>", ":resize -1<CR>", desc = "Decrease window height" },
        { "<Down>", ":resize +1<CR>", desc = "Increase window height" },

        { "<esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit terminal mode" },

        -- Folding (nvim-ufo)
        { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
        { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    })
end

return M
