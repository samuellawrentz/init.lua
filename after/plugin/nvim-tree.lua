-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

local api = require("nvim-tree.api")
vim.keymap.set('n', '?', api.tree.toggle_help,
    { desc = 'Help', buffer = bufnr, noremap = true, silent = true, nowait = true })
vim.keymap.set('n', 'tt', api.tree.toggle,
    { desc = 'Toggle the view of the tree', buffer = bufnr, noremap = true, silent = true, nowait = true })
vim.keymap.set('n', 'tf', api.tree.focus,
    { desc = 'Focus the tree', buffer = bufnr, noremap = true, silent = true, nowait = true })



-- Opens the tree when you start vim
local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too


-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    renderer = {
        group_empty = true,
        highlight_opened_files = 'icon',
        root_folder_label = false
    },
    respect_buf_cwd = true,
    view = {
        relativenumber = true,
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
                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
        width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
    },
    update_focused_file = {
        enable = true,
        update_root = true,
    }
})
