vim.opt.guicursor = ""
vim.g.mapleader = " "
vim.o.winborder = 'rounded'
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.splitright = true
vim.opt.ignorecase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fcs = 'eob: ' -- hide ~ at end of file

vim.opt.timeoutlen = 300

vim.opt.smartindent = true
vim.opt.cursorline = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- folding (nvim-ufo)
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'D', [[<Cmd>put = strftime('%Y-%m-%d -- %B %d, %a, %Y -- %H:%M')<CR>]], { silent = true })

vim.filetype.add({ extension = { mdx = "markdown" } })

local au = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup("samsden", { clear = true })
au("TextYankPost", { group = grp, callback = function() vim.hl.on_yank({ higroup = "Search", timeout = 200 }) end })
au("FileType", { group = grp, command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" })
au("FileType", { group = grp, pattern = "markdown", command = "setlocal wrap spell" })
au("FileType", { group = grp, pattern = "qf", command = "setlocal nobuflisted" })
au("VimResized", { group = grp, command = "wincmd =" })
