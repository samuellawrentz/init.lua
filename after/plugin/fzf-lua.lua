require('fzf-lua').setup {
    winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        preview = {
            layout = 'vertical',
            vertical = 'up:60%',
            default = 'bat',
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
