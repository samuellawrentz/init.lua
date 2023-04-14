require("samsden.set")

vim.cmd([[
  augroup filetypedetect
    autocmd! BufNewFile,BufFilePre,BufRead *.mdx set filetype=markdown
  augroup END
]])

function R(name)
    require("plenary.reload").reload_module(name)
end

