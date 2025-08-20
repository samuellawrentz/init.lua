require("zen-mode").setup()

vim.keymap.set('n', '<leader>zz', function()
    require("zen-mode").toggle({
        window = {
            width = .55 -- width will be 85% of the editor width
        }
    })
end)
