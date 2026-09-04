# AGENTS.md - Neovim Configuration

## Build/Test Commands
- No build system - this is a Neovim configuration
- Test configuration: `nvim --headless "+lua vim.schedule(function() vim.cmd('qa!') end)"` (no output = clean load)
- Plugin management: `:Lazy` (install/update/sync plugins)
- LSP management: `:Mason` (install/manage language servers)

## Layout
- `init.lua` → `lua/samsden/set.lua` (options, autocmds) → `lua/samsden/lazy.lua` (all plugin specs, config via `opts`) → `lua/samsden/theme.lua` (persisted colorscheme in `.theme`)
- All keymaps: `lua/config/whichkey.lua`, except buffer-local gitsigns maps in its `on_attach`
- `lua/samsden/workspace-diff.lua`: multi-repo changed-files picker (`<leader>dw`)
- No `after/plugin/` — a `require()` there loads every plugin at startup and defeats lazy loading. Put plugin config in the spec's `opts`/`config`; `require()` plugins only inside keymap callbacks.

## Conventions
- Leader key: `<space>`; 4-space indent; snake_case files
- LSP: mason + mason-lspconfig v2 (auto `vim.lsp.enable`) + nvim-cmp; no lsp-zero
- Lint/format: biome via nvim-lint + `biome check --write` on BufWritePre
- Colorschemes are `lazy = true`; lazy.nvim loads them on `:colorscheme`
