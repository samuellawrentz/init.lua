-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim"
    use {
        "folke/which-key.nvim",
        config = function()
            require("config.whichkey").setup()
        end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }


    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'onsails/lspkind.nvim'},

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require("nvim-tree").setup {}
        end
    }

    -- use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }
    use 'wakatime/vim-wakatime'
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use 'windwp/nvim-autopairs'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Lua
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    -- Lua
    use({
        "Bryley/neoai.nvim",
        requires = { "MunifTanjim/nui.nvim" },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },
        config = function()
            require("neoai").setup({
                -- Options go here
                ui = {
                    output_popup_text = "Sam's Personal AI",
                    input_popup_text = "Prompt",
                    width = 40,               -- As percentage eg. 30%
                    output_popup_height = 80, -- As percentage eg. 80%
                    submit = "<Enter>",       -- Key binding to submit the prompt
                },
                models = {
                    {
                        name = "openai",
                        model = "gpt-4",
                        params = nil,
                    },
                },
                prompts = {
                    context_prompt = function(context)
                        return "Hey, I'd like to provide some context for future "
                            .. "messages. Here is the code/text that I want to refer "
                            .. "to in our upcoming conversations:\n\n"
                            .. context
                            .. "\n\n Note: Please give a brief, focused response, cutting off any unnecessary details or lengthy explanations."
                    end,
                },
            })
        end,
    })

    use 'tpope/vim-commentary'
end)
