local M = {}

function M.setup()
    local wk = require("which-key")


    local mappings = {

        { "<leader>b", group = "Buffer", nowait = false, remap = false },
        { "<leader>bD", "<Cmd>%bd|e#|bd#<Cr>", desc = "Delete all buffers", nowait = false, remap = false },
        { "<leader>bc", "<Cmd>bd!<Cr>", desc = "Close current buffer", nowait = false, remap = false },
        { "<leader>q", "<cmd>qa!<CR>", desc = "Quit", nowait = false, remap = false },

        { "<leader>z", group = "Utils", nowait = false, remap = false },
        { "<leader>zS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = false, remap = false },
        { "<leader>zc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = false, remap = false },
        { "<leader>zi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = false, remap = false },
        { "<leader>zm", "<cmd>Mason<cr>", desc = "Open Mason", nowait = false, remap = false },
        { "<leader>zs", "<cmd>PackerSync<cr>", desc = "Sync", nowait = false, remap = false },
        { "<leader>zu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = false, remap = false },
        -- Session
        { "<leader>zr", "<cmd>:SessionRestore<CR>", desc = "Restore session", nowait = false, remap = false },

        -- Yanky
        { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
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
        -- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
        -- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
        -- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
        -- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
        -- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
        -- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },

    }
    wk.add(mappings)
end

return M
