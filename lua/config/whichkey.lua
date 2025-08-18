local M = {}

function M.setup()
    local wk = require("which-key")
    local harpoon = require("harpoon")
    local fzf = require('fzf-lua')
    local api = require("nvim-tree.api")
    local snipe = require("snipe")

    local mappings = {
        -- Buffer management
        { "<leader>b", group = "Buffer", nowait = false, remap = false },
        { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>", desc = "Delete all buffers", nowait = false, remap = false },
        { "<leader>bc", "<Cmd>bd!<Cr>", desc = "Close current buffer", nowait = false, remap = false },
        { "<leader>bt", ":BufferTabsToggle<CR>", desc = "Toggle buffer tabs", nowait = false, remap = false },
        { "<leader>qa", "<cmd>qa!<CR>", desc = "Quit", nowait = false, remap = false },

        -- Utils/Tools
        { "<leader>z", group = "Utils", nowait = false, remap = false },
        { "<leader>zS", "<cmd>Lazy<cr>", desc = "Lazy Status", nowait = false, remap = false },
        { "<leader>zc", "<cmd>Lazy clean<cr>", desc = "Lazy Clean", nowait = false, remap = false },
        { "<leader>zi", "<cmd>Lazy install<cr>", desc = "Lazy Install", nowait = false, remap = false },
        { "<leader>zm", "<cmd>Mason<cr>", desc = "Open Mason", nowait = false, remap = false },
        { "<leader>zs", "<cmd>Lazy sync<cr>", desc = "Lazy Sync", nowait = false, remap = false },
        { "<leader>zu", "<cmd>Lazy update<cr>", desc = "Lazy Update", nowait = false, remap = false },
        { "<leader>zr", "<cmd>:SessionRestore<CR>", desc = "Restore session", nowait = false, remap = false },

        -- File operations
        { "<leader>f", group = "Find/Files", nowait = false, remap = false },
        { "<leader>ff", function() fzf.live_grep() end, desc = "Live grep", nowait = false, remap = false },
        { "<leader>fg", function() fzf.grep_cword() end, desc = "Grep word under cursor", nowait = false, remap = false },
        { "<leader>fb", function() fzf.buffers() end, desc = "Find buffers", nowait = false, remap = false },
        { "<leader>fG", function() fzf.resume() end, desc = "Resume last search", nowait = false, remap = false },
        { "<leader>fj", function() snipe.open_buffer_menu() end, desc = "Snipe buffer menu", nowait = false, remap = false },

        -- LSP
        { "<leader>l", group = "LSP", nowait = false, remap = false },
        { "<leader>lw", function() fzf.lsp_live_workspace_symbols() end, desc = "Workspace symbols", nowait = false, remap = false },
        { "<leader>lk", function() vim.diagnostic.open_float() end, desc = "Open diagnostic float", nowait = false, remap = false },
        { "<leader>ld", function() fzf.diagnostics_document() end, desc = "Buffer diagnostics", nowait = false, remap = false },
        { "<leader>ls", function() fzf.lsp_document_symbols() end, desc = "Document symbols", nowait = false, remap = false },
        { "<leader>lt", function() fzf.lsp_typedefs() end, desc = "Type definitions", nowait = false, remap = false },
        { "<leader>lo", function() fzf.lsp_outgoing_calls() end, desc = "Outgoing calls", nowait = false, remap = false },
        { "<leader>li", function() fzf.lsp_incoming_calls() end, desc = "Incoming calls", nowait = false, remap = false },
        { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename symbol", nowait = false, remap = false },
        { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "Code actions", nowait = false, remap = false },
        { "<leader>lx", function()
            local virtual_text = not vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_text = virtual_text, underline = virtual_text })
        end, desc = "Toggle diagnostic virtual text", nowait = false, remap = false },

        -- AI
        { "<leader>a", group = "AI", nowait = false, remap = false },
        { "<leader>ai", ":NeoAI<CR>", desc = "NeoAI", mode = { "n", "x" }, nowait = false, remap = false },
        { "<leader>ac", ":NeoAIContext<CR>", desc = "NeoAI Context", mode = { "n", "x" }, nowait = false, remap = false },

        -- GitHub
        { "<leader>o", group = "Open in GitHub", nowait = false, remap = false },
        { "<leader>or", ":OpenInGHRepo <CR>", desc = "Open repo in GitHub", nowait = false, remap = false },
        { "<leader>of", ":OpenInGHFile <CR>", desc = "Open file in GitHub", mode = { "n", "v" }, nowait = false, remap = false },

        -- Harpoon
        { "<leader>1", function() harpoon:list():select(1) end, desc = "Harpoon file 1", nowait = false, remap = false },
        { "<leader>2", function() harpoon:list():select(2) end, desc = "Harpoon file 2", nowait = false, remap = false },
        { "<leader>3", function() harpoon:list():select(3) end, desc = "Harpoon file 3", nowait = false, remap = false },
        { "<leader>4", function() harpoon:list():select(4) end, desc = "Harpoon file 4", nowait = false, remap = false },

        -- Yanky
        { "<leader>p", function() require("yanky.picker").actions.put("p") end, desc = "Open Yank History" },
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
        { "<c-y>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
        { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
        { "<leader>pa", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
        { "<leader>pb", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
        { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
        { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },

        -- Misc leader mappings
        { "<leader>s", "<cmd>so<cr>", desc = "Source file", nowait = false, remap = false },
        { "<leader>/", function() fzf.blines() end, desc = "Fuzzy search current buffer", nowait = false, remap = false },
        { "<leader>vh", function() fzf.help_tags() end, desc = "Help tags", nowait = false, remap = false },

        -- Navigation and movement
        { "jk", "<ESC>", mode = "i", desc = "Exit insert mode", nowait = false, remap = false },
        { "\\", "<C-w>w", desc = "Switch window", nowait = false, remap = false },
        { ",", "<C-w>", desc = "Window command prefix", nowait = false, remap = false },
        { "U", "<C-r>", desc = "Redo", nowait = false, remap = false },
        { "H", "^", desc = "Go to line start", nowait = false, remap = false },
        { "L", "$", desc = "Go to line end", nowait = false, remap = false },
        { "n", "nzz", desc = "Next search result (centered)", nowait = false, remap = false },
        { "N", "Nzz", desc = "Previous search result (centered)", nowait = false, remap = false },
        { "k", "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move up (display lines)", nowait = false, remap = false },
        { "j", "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move down (display lines)", nowait = false, remap = false },

        -- Visual mode
        { "<", "<gv", mode = "v", desc = "Indent left and reselect", nowait = false, remap = false },
        { ">", ">gv", mode = "v", desc = "Indent right and reselect", nowait = false, remap = false },
        { "K", ":move '<-2<CR>gv-gv", mode = "x", desc = "Move selection up", nowait = false, remap = false },
        { "J", ":move '>+1<CR>gv-gv", mode = "x", desc = "Move selection down", nowait = false, remap = false },

        -- Text objects and editing
        { "cw", '"_ciw', desc = "Change word (no yank)", nowait = false, remap = false },
        { "dw", '"_diw', desc = "Delete word (no yank)", nowait = false, remap = false },
        { "vw", "viw", desc = "Select word", nowait = false, remap = false },
        { "vC", 'vi"', desc = "Select inside double quotes", nowait = false, remap = false },
        { "vb", "vib", desc = "Select inside parentheses", nowait = false, remap = false },
        { "vc", "vi'", desc = "Select inside single quotes", nowait = false, remap = false },
        { "vB", "viB", desc = "Select inside braces", nowait = false, remap = false },
        { "dB", "diB", desc = "Delete inside braces", nowait = false, remap = false },
        { "db", "dib", desc = "Delete inside parentheses", nowait = false, remap = false },
        { "dc", "di'", desc = "Delete inside single quotes", nowait = false, remap = false },
        { "dC", 'di"', desc = "Delete inside double quotes", nowait = false, remap = false },
        { "cB", "ciB", desc = "Change inside braces", nowait = false, remap = false },
        { "cb", "cib", desc = "Change inside parentheses", nowait = false, remap = false },
        { "cc", '"_ci\'', desc = "Change inside single quotes (no yank)", nowait = false, remap = false },
        { "cC", '"_ci"', desc = "Change inside double quotes (no yank)", nowait = false, remap = false },
        { "x", '"_x', desc = "Delete character (no yank)", nowait = false, remap = false },
        { "S", '"_S', desc = "Substitute line (no yank)", nowait = false, remap = false },
        { "s", '"_s', desc = "Substitute character (no yank)", nowait = false, remap = false },
        { "<cr>", '"_ciw', desc = "Change word (no yank)", nowait = false, remap = false },

        -- Control mappings
        { "<C-s>", "<cmd>update!<CR><ESC>", mode = { "n", "i" }, desc = "Save file", nowait = false, remap = false },
        { "<C-q>", "<cmd>wa<CR><ESC>", mode = { "n", "i" }, desc = "Save all files", nowait = false, remap = false },
        { "<C-j>", "10j", desc = "Jump down 10 lines", nowait = false, remap = false },
        { "<C-k>", "10k", desc = "Jump up 10 lines", nowait = false, remap = false },
        { "<C-d>", "<C-d>zz", desc = "Half page down (centered)", nowait = false, remap = false },
        { "<C-u>", "<C-u>zz", desc = "Half page up (centered)", nowait = false, remap = false },
        { "<C-p>", function() fzf.combine({ pickers = "buffers;git_files" })end, desc = "Find git files", nowait = false, remap = false },
        { "<C-r>", "<C-^>", desc = "Switch to alternate buffer", nowait = false, remap = false },
        { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle Harpoon menu", nowait = false, remap = false },
        { "<C-f>", function() fzf.buffers() end, desc = "Find buffers", nowait = false, remap = false },

        -- Copilot (Insert Mode)
        { "<C-g>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept Copilot word", nowait = false, remap = false },
        { "<C-d>", "<Plug>(copilot-next)", mode = "i", desc = "Next Copilot suggestion", nowait = false, remap = false },
        { "<C-f>", "<Plug>(copilot-previous)", mode = "i", desc = "Previous Copilot suggestion", nowait = false, remap = false },
        { "<C-v>", "<Plug>(copilot-accept-line)", mode = "i", desc = "Accept Copilot line", nowait = false, remap = false },
        { "<C-c>", "<Cmd>Copilot<CR>", mode = "i", desc = "Open Copilot", nowait = false, remap = false },

        -- Arrow keys for resizing
        { "<Left>", ":vertical resize +1<CR>", desc = "Increase window width", nowait = false, remap = false },
        { "<Right>", ":vertical resize -1<CR>", desc = "Decrease window width", nowait = false, remap = false },
        { "<Up>", ":resize -1<CR>", desc = "Decrease window height", nowait = false, remap = false },
        { "<Down>", ":resize +1<CR>", desc = "Increase window height", nowait = false, remap = false },

        -- Special keys
        { "<ESC>", ":nohlsearch<Bar>:echo<CR>", desc = "Clear search highlight", nowait = false, remap = false },
        { "<esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit terminal mode", nowait = false, remap = false },

        -- LSP specific (buffer local)
        { "gd", function() vim.lsp.buf.definition() end, desc = "Go to definition", nowait = false, remap = false },
        { "K",  function()  vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 } end, desc = "Hover documentation", nowait = false, remap = false },
        { "[d", function() vim.diagnostic.goto_next() end, desc = "Next diagnostic", nowait = false, remap = false },
        { "]d", function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic", nowait = false, remap = false },
        { "gr", function() fzf.lsp_references() end, desc = "Go to references", nowait = false, remap = false },

        -- Tree navigation
        { "?", api.tree.toggle_help, desc = "Toggle nvim-tree help", nowait = false, remap = false },
        { "tf", api.tree.toggle, desc = "Toggle nvim-tree", nowait = false, remap = false },
        { "tt", api.tree.focus, desc = "Focus nvim-tree", nowait = false, remap = false },

        -- Folding
        { "zR", require('ufo').openAllFolds, desc = "Open all folds", nowait = false, remap = false },
        { "zM", require('ufo').closeAllFolds, desc = "Close all folds", nowait = false, remap = false },
    }
    wk.add(mappings)
end

return M
