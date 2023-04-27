local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
lsp.skip_server_setup({'tsserver'})

-- (Optional) Configure lua language server for neovim
 local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.emmet_ls.setup {}
-- lspconfig.eslint_d.setup {}
lspconfig.prettierd.setup {}
lspconfig.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lsp.setup()

require('typescript').setup({
  server = {
    on_attach = function(client, bufnr)
      -- You can find more commands in the documentation:
      -- https://github.com/jose-elias-alvarez/typescript.nvim#commands

      vim.keymap.set('n', '<leader>ti', '<cmd>TypescriptAddMissingImports<cr>', {buffer = bufnr})
      vim.keymap.set('n', '<leader>tt', '<cmd>TypescriptFixAll<cr>', {buffer = bufnr})
      vim.keymap.set('n', 'gd', '<cmd>TypescriptGoToSourceDefinition<cr>', {buffer = bufnr})
    end
  }
})
