vim.opt.guicursor = ""
vim.g.mapleader = " "
vim.g.copilot_filetypes = {
    markdown = true,
    mdx = true
}
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.splitright = true -- vertical split to the right, for github copilot panel C-c

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.fcs = 'eob: ' -- hide ~ at end of file

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.timeoutlen = 300

vim.opt.smartindent = true
vim.opt.cursorline = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.g.autochdir = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.api.nvim_set_keymap('n', 'D', [[<Cmd>put = strftime('%Y-%m-%d -- %B %d, %a, %Y -- %H:%M')<CR>]],
    { noremap = true, silent = true })

