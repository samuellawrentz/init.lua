-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()

local api = require("nvim-tree.api")
vim.keymap.set('n', '?', api.tree.toggle_help,   { desc = 'Help',  buffer = bufnr, noremap = true, silent = true, nowait = true })
vim.keymap.set('n', 'tt', api.tree.toggle,   { desc = 'Toggle the view of the tree',  buffer = bufnr, noremap = true, silent = true, nowait = true })
vim.keymap.set('n', 'tf', api.tree.focus,   { desc = 'Focus the tree',  buffer = bufnr, noremap = true, silent = true, nowait = true })

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    on_attach = on_attach,
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})
