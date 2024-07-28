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

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
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
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

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
                        return "Hey, I'd like to provide some context for future"
                            .. "messages. Here is the code/text that I want to refer"
                            .. "to in our upcoming conversations:\n\n"
                            .. context
                            .. "\n\n Note: Please give a brief, focused response, cutting off any unnecessary details or lengthy explanations."
                    end,
                },
            })
        end,
    })

    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-commentary'
    use "almo7aya/openingh.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use 'arkav/lualine-lsp-progress'
    use 'gorbit99/codewindow.nvim'
    use 'rmagatti/auto-session'
    use 'nvim-tree/nvim-web-devicons'
    use 'wakatime/vim-wakatime'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'folke/zen-mode.nvim'
    use 'gbprod/yanky.nvim'
    use 'kylechui/nvim-surround'
    use 'axkirillov/hbac.nvim'
end)
