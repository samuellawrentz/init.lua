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
    }
    wk.add(mappings)
end

return M
