require("yanky").setup({
    ring = {
        history_length = 50,
        sync_with_numbered_registers = false,
        ignore_registers = { "_" },
    },
    highlight = {
        timer = 200,
        on_yank = true,
        on_put = true,
    },
    picker = {
        fzf_lua = {
            use_default_mappings = true,
        }
    }
})
