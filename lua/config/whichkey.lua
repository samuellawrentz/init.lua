local M = {}

function M.setup()
    local whichkey = require "which-key"

    local conf = {
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
    }

    local opts = {
        mode = "n", -- Normal mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
    }

    local M = {}
    local mappings = {
        ["q"] = { "<cmd>q!<CR>", "Quit" },
        b = {
            name = "Buffer",
            c = { "<Cmd>bd!<Cr>", "Close current buffer" },
            D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
        },
        z = {
            name = "Utils",
            c = { "<cmd>PackerCompile<cr>", "Compile" },
            i = { "<cmd>PackerInstall<cr>", "Install" },
            s = { "<cmd>PackerSync<cr>", "Sync" },
            S = { "<cmd>PackerStatus<cr>", "Status" },
            u = { "<cmd>PackerUpdate<cr>", "Update" },
            m = { "<cmd>Mason<cr>", "Open Mason" },
        },
    }

    whichkey.setup(conf)
    whichkey.register(mappings, opts)
end

return M
