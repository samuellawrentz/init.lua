require('fzf-lua').setup {
    winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        preview = {
            layout = 'flex',
            flip_columns = 120,
            default = 'bat',
            horizontal = 'right:50%'
        },
    },
    keymap = {
        builtin = {
            ["<F1>"] = "toggle-help",
            ["<F2>"] = "toggle-fullscreen",
            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
        },
        fzf = {
            ["ctrl-z"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"] = "select-all",
            ["alt-d"] = "deselect-all",
        },
    },
    previewers = {
        bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            theme = 'Coldark-Dark',
        },
    },
    files = {
        prompt = 'Files❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        path_shorten = 1,
        actions = {
            ["default"] = require("fzf-lua.actions").file_edit_or_qf,
            ["ctrl-s"] = require("fzf-lua.actions").file_split,
            ["ctrl-v"] = require("fzf-lua.actions").file_vsplit,
            ["ctrl-t"] = require("fzf-lua.actions").file_tabedit,
        }
    },
    grep = {
        prompt = 'Rg❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        actions = {
            ["default"] = require("fzf-lua.actions").file_edit_or_qf,
            ["ctrl-s"] = require("fzf-lua.actions").file_split,
            ["ctrl-v"] = require("fzf-lua.actions").file_vsplit,
            ["ctrl-t"] = require("fzf-lua.actions").file_tabedit,
        }
    },
    buffers = {
        prompt = 'Buffers❯ ',
        file_icons = true,
        color_icons = true,
        sort_mru = true,
        actions = {
            ["default"] = require("fzf-lua.actions").buf_edit,
            ["ctrl-s"] = require("fzf-lua.actions").buf_split,
            ["ctrl-v"] = require("fzf-lua.actions").buf_vsplit,
            ["ctrl-t"] = require("fzf-lua.actions").buf_tabedit,
        }
    },
    git = {
        files = {
            prompt = 'GitFiles❯ ',
            cmd = 'git ls-files --exclude-standard',
            multiprocess = true,
            git_icons = true,
            file_icons = true,
            color_icons = true,
        }
    },
    lsp = {
        prompt_postfix = '❯ ',
        cwd_only = false,
        async_or_timeout = 5000,
        file_icons = true,
        git_icons = false,
        lsp_icons = true,
        ui_select = true,
        symbol_style = 1,
    }
}
