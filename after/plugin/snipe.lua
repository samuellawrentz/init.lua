    local snipe = require("snipe")
    snipe.setup()
    vim.keymap.set("n", "<leader>fj", function() snipe.open_buffer_menu() end)
