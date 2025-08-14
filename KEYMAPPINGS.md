# Neovim Keymappings

## Leader Key Mappings

### Buffer Management (`<leader>b`)
| Key | Description |
|-----|-------------|
| `<leader>bD` | Delete all buffers |
| `<leader>bc` | Close current buffer |
| `<leader>bt` | Toggle buffer tabs |

### Find/Files (`<leader>f`)
| Key | Description |
|-----|-------------|
| `<leader>ff` | Live grep |
| `<leader>fg` | Grep word under cursor |
| `<leader>fb` | Find buffers |
| `<leader>fG` | Resume last search |
| `<leader>fj` | Snipe buffer menu |

### LSP (`<leader>v`)
| Key | Description |
|-----|-------------|
| `<leader>vws` | Workspace symbols |
| `<leader>vd` | Open diagnostic float |
| `<leader>vca` | Code actions |
| `<leader>vrn` | Rename symbol |

### LSP Extended (`<leader>l`)
| Key | Description |
|-----|-------------|
| `<leader>ld` | Buffer diagnostics |
| `<leader>ls` | Document symbols |
| `<leader>lt` | Type definitions |
| `<leader>lo` | Outgoing calls |
| `<leader>li` | Incoming calls |
| `<leader>lx` | Toggle diagnostic virtual text |

### AI (`<leader>a`)
| Key | Description |
|-----|-------------|
| `<leader>ai` | NeoAI (normal/visual) |
| `<leader>ac` | NeoAI Context (normal/visual) |

### GitHub (`<leader>o`)
| Key | Description |
|-----|-------------|
| `<leader>or` | Open repo in GitHub |
| `<leader>of` | Open file in GitHub (normal/visual) |

### Utils (`<leader>z`)
| Key | Description |
|-----|-------------|
| `<leader>zS` | Packer Status |
| `<leader>zc` | Packer Compile |
| `<leader>zi` | Packer Install |
| `<leader>zm` | Open Mason |
| `<leader>zs` | Packer Sync |
| `<leader>zu` | Packer Update |
| `<leader>zr` | Restore session |

### Harpoon (Number Keys)
| Key | Description |
|-----|-------------|
| `<leader>1` | Harpoon file 1 |
| `<leader>2` | Harpoon file 2 |
| `<leader>3` | Harpoon file 3 |
| `<leader>4` | Harpoon file 4 |

### Yanky (`<leader>p`)
| Key | Description |
|-----|-------------|
| `<leader>p` | Open Yank History |
| `<leader>pa` | Put indented after cursor (linewise) |
| `<leader>pb` | Put indented before cursor (linewise) |

### Misc Leader Mappings
| Key | Description |
|-----|-------------|
| `<leader>s` | Source file |
| `<leader>vh` | Help tags |
| `<leader>qa` | Quit |

## Control Key Mappings

| Key | Mode | Description |
|-----|------|-------------|
| `<C-s>` | Normal/Insert | Save file |
| `<C-q>` | Normal/Insert | Save all files |
| `<C-j>` | Normal | Jump down 10 lines |
| `<C-k>` | Normal | Jump up 10 lines |
| `<C-d>` | Normal | Half page down (centered) |
| `<C-u>` | Normal | Half page up (centered) |
| `<C-p>` | Normal | Find git files |
| `<C-r>` | Normal | Switch to alternate buffer |
| `<C-e>` | Normal | Toggle Harpoon menu |
| `<C-f>` | Normal | Find buffers |
| `<C-y>` | Normal | Select previous entry through yank history |
| `<C-n>` | Normal | Select next entry through yank history |

### Copilot (Insert Mode)
| Key | Description |
|-----|-------------|
| `<C-g>` | Accept Copilot word |
| `<C-d>` | Next Copilot suggestion |
| `<C-f>` | Previous Copilot suggestion |
| `<C-v>` | Accept Copilot line |
| `<C-c>` | Open Copilot |

## Navigation & Movement

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `\\` | Normal | Switch window |
| `,` | Normal | Window command prefix |
| `U` | Normal | Redo |
| `H` | Normal | Go to line start |
| `L` | Normal | Go to line end |
| `n` | Normal | Next search result (centered) |
| `N` | Normal | Previous search result (centered) |
| `k` | Normal | Move up (display lines) |
| `j` | Normal | Move down (display lines) |

## Visual Mode

| Key | Description |
|-----|-------------|
| `<` | Indent left and reselect |
| `>` | Indent right and reselect |
| `K` | Move selection up |
| `J` | Move selection down |

## Text Objects & Editing

### Word Operations
| Key | Description |
|-----|-------------|
| `cw` | Change word (no yank) |
| `dw` | Delete word (no yank) |
| `vw` | Select word |

### Quote Operations
| Key | Description |
|-----|-------------|
| `vC` | Select inside double quotes |
| `vc` | Select inside single quotes |
| `dC` | Delete inside double quotes |
| `dc` | Delete inside single quotes |
| `cC` | Change inside double quotes (no yank) |
| `cc` | Change inside single quotes (no yank) |

### Bracket Operations
| Key | Description |
|-----|-------------|
| `vb` | Select inside parentheses |
| `vB` | Select inside braces |
| `db` | Delete inside parentheses |
| `dB` | Delete inside braces |
| `cb` | Change inside parentheses |
| `cB` | Change inside braces |

### Character Operations
| Key | Description |
|-----|-------------|
| `x` | Delete character (no yank) |
| `S` | Substitute line (no yank) |
| `s` | Substitute character (no yank) |
| `<cr>` | Change word (no yank) |

## Yanky Operations

| Key | Mode | Description |
|-----|------|-------------|
| `y` | Normal/Visual | Yank text |
| `p` | Normal/Visual | Put yanked text after cursor |
| `P` | Normal/Visual | Put yanked text before cursor |
| `gp` | Normal/Visual | Put yanked text after selection |
| `gP` | Normal/Visual | Put yanked text before selection |
| `]P` | Normal | Put indented after cursor (linewise) |
| `[P` | Normal | Put indented before cursor (linewise) |

## LSP Mappings

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `[d` | Next diagnostic |
| `]d` | Previous diagnostic |
| `gr` | Go to references |

## Window Resizing (Arrow Keys)

| Key | Description |
|-----|-------------|
| `<Left>` | Increase window width |
| `<Right>` | Decrease window width |
| `<Up>` | Decrease window height |
| `<Down>` | Increase window height |

## Tree Navigation

| Key | Description |
|-----|-------------|
| `?` | Toggle nvim-tree help |
| `tf` | Toggle nvim-tree |
| `tt` | Focus nvim-tree |

## Folding

| Key | Description |
|-----|-------------|
| `zR` | Open all folds |
| `zM` | Close all folds |

## Special Keys

| Key | Mode | Description |
|-----|------|-------------|
| `<ESC>` | Normal | Clear search highlight |
| `<esc>` | Terminal | Exit terminal mode |