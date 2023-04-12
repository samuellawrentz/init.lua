local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
-- keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Save buffer on ctrl-s
keymap("i", "<C-s>", "<cmd>update!<CR><ESC>", default_opts)
keymap("n", "<C-s>", "<cmd>update!<CR><ESC>", default_opts)
keymap("n", "<C-q>", "<cmd>wa<CR><ESC>", default_opts)
keymap("i", "<C-q>", "<cmd>wa<CR><ESC>", default_opts)

-- Yank
keymap("n", "y", '"+y', default_opts)
-- Yank whole line without the newline character
keymap("n", "Y", '0"+y$', default_opts)

-- Undo/Redo
keymap("n", "U", "<C-r>", default_opts)

-- Navigation
keymap("n", "<C-j>", "5j", default_opts)
keymap("n", "<C-k>", "5k", default_opts)
keymap("n", "H", "^", default_opts)
keymap("n", "L", "$", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Selection remaps
keymap("n", "cw", "ciw", default_opts)
keymap("n", "dw", "diw", default_opts)
keymap("n", "vw", "viw", default_opts)
keymap("n", "yw", "yiw", default_opts)

keymap("n", 'vC', 'vi"', default_opts)
keymap("n", 'vb', 'vib', default_opts)
keymap("n", "vc", "vi'", default_opts)
keymap("n", "vB", "viB", default_opts)
-- Implment the above four keymaps for yank, delete, change
keymap("n", "yB", "yiB", default_opts)
keymap("n", "yb", "yib", default_opts)
keymap("n", "yc", "yi'", default_opts)
keymap("n", "yC", 'yi"', default_opts)

keymap("n", "dB", "diB", default_opts)
keymap("n", "db", "dib", default_opts)
keymap("n", "dc", "di'", default_opts)
keymap("n", "dC", 'di"', default_opts)

keymap("n", "cB", "ciB", default_opts)
keymap("n", "cb", "cib", default_opts)
keymap("n", "cc", "ci'", default_opts)
keymap("n", "cC", 'ci"', default_opts)

-- Switch buffer
-- keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
-- keymap("n", "<S-j>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Move to previous/next
keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', default_opts)
keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', default_opts)
-- Re-order to previous/next
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', default_opts)
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', default_opts)
-- Goto buffer in position...
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', default_opts)
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', default_opts)
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', default_opts)
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', default_opts)
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', default_opts)
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', default_opts)
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', default_opts)
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', default_opts)
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', default_opts)
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', default_opts)
-- Pin/unpin buffer
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', default_opts)
-- Close buffer
keymap('n', '<A-w>', '<Cmd>w|BufferClose<CR>', default_opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
 keymap('n', '<C-p>', "<cmd>Telescope git_files<cr>", default_opts)
 keymap('n', '<leader>fg', "<cmd>Telescope resume<cr>", default_opts)
 keymap('n', '<leader>s', "<cmd>so<cr>", default_opts)
-- Sort automatically by...
keymap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', default_opts)
keymap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', default_opts)
keymap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', default_opts)
keymap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', default_opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
keymap("t", "<esc>", [[<C-\><C-n>]], default_opts)
