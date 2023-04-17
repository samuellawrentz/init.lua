local lualine = require('lualine')

local config = {
    options = {
        icons_enabled = true,
        theme = 'moonfly',
        section_separators = { left = '', right = ''},
        component_separators = { left = '|', right = '|'},
        disabled_filetypes = {"coc-explorer"},
        always_divide_middle = false,
    },
    sections = {
        lualine_a = {{ 'mode', separator = { left = '', right = ''}}},
        lualine_b = {'branch', 'diff',
            {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {{'datetime' ,
            style = "%a %b %d, %H:%M,",
            separator = { left = '', right = ''}}},
    },
    inactive_sections = {
        lualine_a = {'filename'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

lualine.setup(config)
