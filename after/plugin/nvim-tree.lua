-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require("nvim-tree.api")
-- Nvim-tree keybindings have been moved to lua/config/whichkey.lua for better organization

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        
        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)
        
        -- Custom mappings
        vim.keymap.set("n", "<Esc>", api.tree.close, opts("Close"))
    end,
    renderer = {
        group_empty = true,
        highlight_opened_files = 'icon',
        root_folder_label = false,
    },
    view = {
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2)
                    - vim.opt.cmdheight:get()
                local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                    title = " " .. cwd .. " ",
                    title_pos = "center",
                }
            end,
        },
        width = 40
    },
    update_focused_file = {
        enable = true,
    },
    live_filter = {
        always_show_folders = false
    }
})
