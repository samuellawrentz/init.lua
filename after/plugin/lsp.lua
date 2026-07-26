local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- LSP keybindings are now managed in lua/config/whichkey.lua
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'ts_ls', 'gopls' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        ts_ls = function()
            require('lspconfig').ts_ls.setup({})
        end,
    }
})

-- Ensure biome is installed via Mason
require('mason-tool-installer').setup({
    ensure_installed = {
        'biome',  -- Biome linter/formatter
    },
    auto_update = false,
    run_on_start = true,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }



cmp.setup({
    sources = {
        { name = 'path' },
        { name = "supermaven" },
        { name = 'tailwind-tools' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer',  keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = require('lspkind').cmp_format({
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            show_labelDetails = true, -- show label details like `method` or `text`
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})


