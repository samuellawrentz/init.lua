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

## Verifying changes (headless is not enough)
- `nvim --headless` never attaches LSP clients and never fires VeryLazy/UIEnter. To verify LSP, cmp, or the dashboard, run nvim in a pty (python `pty.fork`) and dump state to a file from a deferred lua callback.
- Do NOT pass `-c` when testing the alpha dashboard: alpha's `should_skip_alpha` treats any `-` argv as "opened explicitly" and stays blank. Type the probe command into the pty instead.
- ts_ls only attaches when the file's tree has BOTH a lockfile (`package-lock.json`/`yarn.lock`/`pnpm-lock.yaml`/`bun.lock`) AND `tsconfig.json`/`jsconfig.json`. A bare `.ts` file with only `package.json` gets no client. That is nvim-lspconfig's root logic, not a config bug.
- biome is auto-enabled as an LSP by mason-lspconfig (installed via mason). Its root needs `biome.json`.
- Count what actually loaded at startup with `require('lazy').plugins()` and `p._.loaded`; a `require()` of a lazy plugin anywhere in init/after path silently loads it eagerly.

## Conventions
- Leader key: `<space>`; 4-space indent; snake_case files
- LSP: mason + mason-lspconfig v2 (auto `vim.lsp.enable`) + nvim-cmp; no lsp-zero
- Lint/format: biome via nvim-lint + `biome check --write` on BufWritePre
- Colorschemes are `lazy = true`; lazy.nvim loads them on `:colorscheme`
