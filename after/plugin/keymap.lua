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

-- For normal mode
keymap('n', '<leader>ai', ':NeoAI<CR>', { noremap = true, silent = true })
keymap('n', '<leader>ac', ':NeoAIContext<CR>', { noremap = true, silent = true })
keymap('n', '<leader>bt', ':BufferTabsToggle<CR>', { noremap = true, silent = true })

-- For visual and visual line modes
keymap('x', '<leader>ai', ':NeoAI<CR>', { noremap = true, silent = true })
keymap('x', '<leader>ac', ':NeoAIContext<CR>', { noremap = true, silent = true })


keymap('n', '<leader>or', ':OpenInGHRepo <CR>', { noremap = true, silent = true })
keymap('n', '<leader>of', ':OpenInGHFile <CR>', { noremap = true, silent = true })
keymap('v', '<leader>of', ':OpenInGHFileLines <CR>', { noremap = true, silent = true })

-- Undo/Redo
keymap("n", "U", "<C-r>", default_opts)

-- Navigation
keymap("n", "<C-j>", "45j", default_opts)
keymap("n", "<C-k>", "45k", default_opts)
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
-- keymap("v", "p", '"*dP', default_opts)
-- keymap("n", "p", '"*p', default_opts)

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


-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)
keymap("n", "<cr>", "ciw", default_opts)
keymap("n", "<C-d>", "<C-d>zz", default_opts)
keymap("n", "<C-u>", "<C-u>zz", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- Move to previous/next
keymap('n', '<leader>,', '<Cmd>BufferPrevious<CR>', default_opts)
keymap('n', '<leader>.', '<Cmd>BufferNext<CR>', default_opts)

-- Re-order to previous/next
keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', default_opts)
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', default_opts)
-- Pin/unpin buffer
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', default_opts)
-- Close buffer
-- keymap('n', '<leader>w', '<Cmd>w|BufferClose<CR>', default_opts)
-- Magic buffer-picking mode
keymap('n', '<C-p>', "<cmd>Telescope git_files<cr>", default_opts)
keymap('n', '<leader>fG', "<cmd>Telescope resume<cr>", default_opts)
keymap('n', '<leader>s', "<cmd>so<cr>", default_opts)
-- Sort automatically by...
keymap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', default_opts)
keymap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', default_opts)
keymap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', default_opts)
keymap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', default_opts)
keymap('n', '<C-r>', '<C-^>', default_opts)

keymap("t", "<esc>", [[<C-\><C-n>]], default_opts)

-- Copilot keymaps
keymap("i", "<C-g>", "<Plug>(copilot-accept-word)", default_opts)
keymap("i", "<C-d>", "<Plug>(copilot-next)", default_opts)
keymap("i", "<C-f>", "<Plug>(copilot-previous)", default_opts)
keymap("i", "<C-v>", "<Plug>(copilot-accept-line)", default_opts)
keymap("i", "<C-c>", "<Cmd>Copilot<CR>", default_opts)

