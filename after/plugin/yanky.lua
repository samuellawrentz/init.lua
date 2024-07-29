local mapping = require("yanky.telescope.mapping")
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
        telescope = {
            use_default_mappings = true,
            mappings = {
                n = {
                    o = mapping.special_put("YankyPutIndentAfterLinewise"),
                    O = mapping.special_put("YankyPutIndentBeforeLinewise")
                },
            }
        }
    }
})
