# 🛠️ Neovim Config - Minimal, Powerful, and Extensible

This Neovim configuration provides a modern, elegant, and productive development environment. Built with Lua and powered by [lazy.nvim](https://github.com/folke/lazy.nvim), it includes advanced support for LSP, intelligent autocompletion, file management, and automatic formatting.

## ✨ Key Features

- 🔌 **Plugin Management** via `lazy.nvim`
- 🎨 **Catppuccin Theme** for a visually pleasing interface
- 🧠 **LSP Support** with `lua_ls` for semantic navigation and completion
- 🧩 **Smart Autocompletion** using `nvim-cmp` and `LuaSnip`
- 📁 **File Explorer** with `neo-tree`
- 🔍 **Advanced Search** using `telescope.nvim`
- 🧼 **Auto Formatting** via `null-ls` (supports Lua and Python)
- 🌲 **Syntax Highlighting & Indentation** with `nvim-treesitter`
- 📊 **Custom Status Line** using `lualine.nvim`

## 📦 Included Plugins

| Plugin | Description |
|--------|-------------|
| `lazy.nvim` | Modern asynchronous plugin manager |
| `catppuccin/nvim` | Elegant and customizable theme |
| `nvim-cmp` | Completion engine |
| `LuaSnip` | Snippet engine |
| `cmp-nvim-lsp` | LSP source for `nvim-cmp` |
| `friendly-snippets` | Predefined snippet collection |
| `mason.nvim` | LSP and external tool manager |
| `mason-lspconfig.nvim` | Mason integration with LSPConfig |
| `nvim-lspconfig` | LSP server configuration |
| `lualine.nvim` | Customizable status line |
| `neo-tree.nvim` | Modern file explorer with icons |
| `none-ls.nvim` | Formatting and linting via LSP |
| `telescope.nvim` | Fuzzy finder and file navigation |
| `telescope-ui-select.nvim` | Enhanced UI for Telescope selections |
| `nvim-treesitter` | Advanced syntax highlighting and parsing |

## 🎯 Custom Keybindings

| Mode   | Key         | Action |
|--------|-------------|--------|
| Visual | `<C-c>`     | Copy to system clipboard |
| Insert | `<C-v>`     | Paste from system clipboard |
| Normal | `<C-n>`     | Open Neo-tree on the left |
| Normal | `<C-b>`     | Close Neo-tree |
| Normal | `<leader>ff`| Find files with Telescope |
| Normal | `<leader>fg`| Live grep with Telescope |
| Normal | `<leader>gf`| Format buffer via LSP |
| Normal | `gd`        | Go to definition |
| Normal | `K`         | Show LSP hover documentation |
| Normal | `<leader>ca`| Show code actions |

> Note: The `leader key` is set to `Space`.

## ⚙️ Basic Settings

- Tabs are replaced with spaces (2 spaces)
- Line numbers are enabled
- Leader key: `Space`

## 🚀 Installation

### Requirements

- Neovim ≥ 0.9
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) (required by Telescope)
- Node.js (required by some LSP/snippet plugins)

### Steps

1. Clone or copy this configuration into your `~/.config/nvim` directory
2. Launch Neovim — plugins will be installed automatically via `lazy.nvim`
3. Make sure `lua_ls`, `stylua`, `black`, and `isort` are installed (use `:Mason` to manage them)
