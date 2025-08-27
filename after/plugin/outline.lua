require("outline").setup({
    outline_window = {
        position = 'right',
        width = 25,
        relative_width = true,
        auto_close = false,
        auto_jump = false,
        jump_highlight_duration = 300,
        center_on_jump = true,
        wrap = false,
        show_cursorline = true,
        hide_cursor = false,
        focus_on_open = true,
    },

    outline_items = {
        show_symbol_details = true,
        show_symbol_lineno = false,
        highlight_hovered_item = true,
        auto_set_cursor = true,
        auto_update_events = {
            -- follow = { 'CursorMoved' },
            items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
        },
    },

    -- guides = {
    --     enabled = true,
    --     markers = {
    --         bottom = '└',
    --         middle = '├',
    --         vertical = '│',
    --     },
    -- },

    symbol_folding = {
        autofold_depth = 1,
        auto_unfold = {
            hovered = true,
            only = true,
        },
        markers = { '', '' },
    },

    preview_window = {
        auto_preview = false,
        open_hover_on_preview = false,
        width = 50,
        min_width = 50,
        relative_width = true,
        height = 50,
        min_height = 10,
        relative_height = true,
        border = 'single',
        winhl = 'NormalFloat:',
        winblend = 0,
        live = false
    },
    -- providers = {
    --     priority = { 'lsp', 'coc', 'markdown', 'norg' },
    --     lsp = {
    --         blacklist_clients = {},
    --     },
    -- },
})
