local actions = require("hbac.telescope.actions")
require("hbac").setup({
    autoclose     = true, -- set autoclose to false if you want to close manually
    threshold     = 15, -- hbac will start closing unedited buffers once that number is reached
    close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
    end,
    close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
    telescope = {
        -- See #telescope-configuration below
        sort_mru = true,
        sort_lastused = true,
        selection_strategy = "row",
        use_default_mappings = true,  -- false to not include the mappings below
        mappings = {
            n = {
                X = actions.close_unpinned,
                x = actions.delete_buffer,
                a = actions.pin_all,
                A = actions.unpin_all,
                p = actions.toggle_pin,
                -- as above
            },
        },
        -- Pinned/unpinned icons and their hl groups. Defaults to nerdfont icons
        pin_icons = {
            pinned = { "x", hl = "DiagnosticOk" },
            unpinned = { " ", hl = "DiagnosticError" },
        },
    },
})
