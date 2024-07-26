local lualine = require('lualine')

local config = {
    options = {
        globalstatus = true,
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
    },
    sections = {},
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_z = { { 'mode', } },
        lualine_y = { 'branch', 'diff',
            { 'diagnostics', sources = { 'nvim_lsp' } } },
        lualine_b = {{ 'filename', path=1 }},
        lualine_c = {'lsp_progress'},
        lualine_x = {},
        lualine_a = {},
    },
}

lualine.setup(config)
