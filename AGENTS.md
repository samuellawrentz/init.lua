# AGENTS.md - Neovim Configuration

## Build/Test Commands
- No build system - this is a Neovim configuration
- Test configuration: `nvim --headless -c "lua print('Config loaded')" -c "qa"`
- Plugin management: `:Lazy` (install/update/sync plugins)
- LSP management: `:Mason` (install/manage language servers)

## Code Style Guidelines
- **Language**: Lua for all configuration files
- **Indentation**: 4 spaces (no tabs) - see `lua/samsden/set.lua:12-15`
- **File structure**: `init.lua` → `lua/samsden/` → `after/plugin/`
- **Imports**: Use `require()` for modules, lazy loading preferred
- **Naming**: snake_case for files/functions, kebab-case for plugin names
- **Comments**: Minimal, only for complex logic explanations
- **Error handling**: Use pcall() for plugin loading when needed

## Key Conventions
- Leader key: `<space>` (set in `lua/samsden/set.lua:2`)
- Plugin management via lazy.nvim with lazy loading
- LSP configuration centralized in `after/plugin/lsp.lua`
- Keymaps organized in `lua/config/whichkey.lua` using which-key groups
- Settings in `lua/samsden/set.lua` following Neovim best practices

## Plugin Architecture
- Core plugins: telescope, nvim-tree, lualine, treesitter, harpoon
- LSP: lsp-zero + mason + nvim-cmp for completion
- Colorscheme: rose-pine theme
- All plugins configured with lazy loading for performance