require("samsden.set")
require("samsden.lazy")

vim.cmd([[
  augroup filetypedetect
    autocmd! BufNewFile,BufFilePre,BufRead *.mdx set filetype=markdown
  augroup END
]])

vim.cmd([[
autocmd FileType harpoon setlocal wrap
]])

function R(name)
    require("plenary.reload").reload_module(name)
end
