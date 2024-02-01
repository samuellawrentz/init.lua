local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
    builtin.live_grep()
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.api.nvim_set_keymap('n', '<leader>fg',
    [[<cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.expand('<cword>') })<CR>]],
    { noremap = true })

-- Define key mapping for listing buffers using Telescope
vim.api.nvim_set_keymap('n', '<C-f>', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ld', ':Telescope diagnostics bufnr=0<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ls', ':Telescope lsp_document_symbols<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lt', ':Telescope lsp_type_definitions<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lo', ':Telescope lsp_outgoing_calls<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>li', ':Telescope lsp_incoming_calls<CR>', { noremap = true, silent = true })


local is_git_dir = function()
    return os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1')
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    callback = function()
        local bufferPath = vim.fn.expand('%:p:h')
        if vim.fn.isdirectory(bufferPath) ~= 0 then
            -- vim.api.nvim_buf_delete(0, { force = true })
            if is_git_dir() == 0 then
                builtin.git_files()
            else
                builtin.find_files()
            end
        end
    end,
})

require('telescope').setup {
    defaults = {
        path_display = { "smart" },
        initial_mode = "normal",
    },
    pickers = {
        git_files = {
            debounce = 400,
            show_untracked = false,
            recurse_submodules = true,
        },
        live_grep = {
            debounce = 400
        }
    }
}
