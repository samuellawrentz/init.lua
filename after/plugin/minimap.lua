local codewindow = require('codewindow')
codewindow.setup({
    minimap_width = 10, -- The width of the text part of the minimap
    screen_bounds = 'background', -- How the visible area is displayed, "lines": lines above and below, "background": background color
    max_lines = 600, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
    auto_enable = true, -- Enable minimap for all buffers with less than max_lines lines
    exclude_filetypes = { 'help' }, -- Choose certain filetypes to not show minimap on
})
codewindow.apply_default_keybinds()
