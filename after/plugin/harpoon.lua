local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- Harpoon keybindings have been moved to lua/config/whichkey.lua for better organization

-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
