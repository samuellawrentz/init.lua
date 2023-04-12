vim.keymap.set('n', '<leader>zz', function()
    require("zen-mode").toggle({
        window = {
            width = .85 -- width will be 85% of the editor width
        }
    })
end)
