require('rose-pine').setup({
    disable_background = true,
    dim_inactive_windows = true,
    styles = {
        bold = true,
        italic = true,
    },
    highlight_groups = {
        -- Comment = { fg = "foam" },
        StatusLine = { fg = "love", bg = "love", blend = 15 },
    },
})

function ColorMyPencils()
    vim.cmd("colorscheme rose-pine")
end

ColorMyPencils()
