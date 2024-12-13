    local snipe = require("snipe")
    snipe.setup()
    vim.keymap.set("n", "<leader>fj", snipe.create_buffer_menu_toggler({ max_path_width = 3}))
