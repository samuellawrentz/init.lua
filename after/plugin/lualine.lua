local lualine = require('lualine')

local config = {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = 'tokyonight',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        disabled_filetypes = { "coc-explorer" },
        always_divide_middle = false,
    },
    sections = {
        lualine_a = { { 'mode', separator = { right = '' } } },
        lualine_b = { 'branch', 'diff',
            { 'diagnostics', sources = { 'nvim_lsp', 'coc' } } },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { {
            'datetime',
            style = "%a %b %d, %H:%M",
            separator = { left = '' }
        } },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualie_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

lualine.setup(config)
