local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
    builtin.live_grep()
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.api.nvim_set_keymap('n', '<leader>fg',
    [[<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>]],
    { noremap = true })
-- Define key mapping for listing buffers using Telescope
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })


local is_git_dir = function()
    return os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1')
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = function()
        local bufferPath = vim.fn.expand('%:p:h')
        if vim.fn.isdirectory(bufferPath) ~= 0 then
            -- vim.api.nvim_buf_delete(0, { force = true })
            if is_git_dir() == 0 then
                builtin.git_files({ show_untracked = true })
            else
                builtin.find_files()
            end
        end
    end,
})
require('telescope').setup{
	defaults = {
		path_display={"smart"},
        initial_mode="normal"
	}
}
