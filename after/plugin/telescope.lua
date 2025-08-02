local builtin = require('telescope.builtin')

-- Telescope keybindings have been moved to lua/config/whichkey.lua for better organization


-- local is_git_dir = function()
--     return os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1')
-- end

-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--     callback = function()
--         local bufferPath = vim.fn.expand('%:p:h')
--         if vim.fn.isdirectory(bufferPath) ~= 0 then
--             -- vim.api.nvim_buf_delete(0, { force = true })
--             if is_git_dir() == 0 then
--                 builtin.git_files()
--             else
--                 builtin.find_files()
--             end
--         end
--     end,
-- })

require('telescope').setup {
    defaults = {
        path_display = { "smart" },
        initial_mode = "normal",
        layout_config = {
            preview_width = 0.45,
        }
    },
    pickers = {
        git_files = {
            show_untracked = false,
            recurse_submodules = true,
        },
        live_grep = {
            debounce = 50
        }
    }
}
