local lualine = require('lualine')

local config = {
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
            {
                'datetime',
                style = "%H:%M"
            }
        }
    }
}

lualine.setup(config)
