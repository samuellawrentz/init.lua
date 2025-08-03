-- Telescope keybindings have been moved to lua/config/whichkey.lua for better organization

require('telescope').setup {
    defaults = {
        path_display = { "smart" },
        initial_mode = "normal",
        layout_config = {
            preview_width = 0.45,
        }
    },
    pickers = {
        git_files = {
            show_untracked = true,
            recurse_submodules = false,
        },
        live_grep = {
            debounce = 50
        }
    }
}
