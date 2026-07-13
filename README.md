# Neovim Configuration

A modular Lua-based Neovim configuration focused on Python development and general text editing, with optional LaTeX support.

## Requirements

- Neovim 0.9+ (Ubuntu 22.04+ default apt version is sufficient)
- `git` (for lazy.nvim bootstrap)
- Formatters (used by none-ls): `black` (via pipx), `prettier` (via npm), `stylua`

**Optional — LaTeX only:**
- `texlab` LSP (auto-installed via Mason)
- [vimtex](https://github.com/lervag/vimtex) PDF viewer: `zathura`
- `xdotool` (for refocusing Neovim after forward search)

## Install

> If you already have a Neovim config at `~/.config/nvim`, back it up first:
> ```bash
> mv ~/.config/nvim ~/.config/nvim.bak
> ```

Clone the repo into the Neovim config directory, then run the install script:

```bash
git clone https://github.com/ducks4rule/nvim_dotfiles ~/.config/nvim
cd ~/.config/nvim
bash install.sh
```

The script will:
- Install Neovim via apt if not already present
- Install `black` (via pipx), `prettier` (via npm), and `stylua`
- On WSL: install `win32yank` for clipboard integration

After that, launch `nvim` — lazy.nvim bootstraps itself and Mason auto-installs the LSP servers on first launch.



## Structure

```
init.lua              # Entry point — loads all modules in order
ftplugin/
  python.lua          # Python-specific keymaps and run helpers
  tex/                # LaTeX-specific keymaps and zathura focus fix
  text.lua            # Spell checking and German umlaut shortcuts
lua/user/
  options.lua         # Editor settings and autocommands
  keymaps.lua         # Global keymaps
  lazy.lua            # Plugin manager bootstrap
  plugins.lua         # Plugin list
  colourscheme.lua    # Colorscheme (darkplus)
  cmp.lua             # Completion setup
  lsp/                # LSP: Mason, handlers, none-ls, per-server settings
  treesitter.lua      # Syntax highlighting and folding
  telescope.lua       # Fuzzy finder
  autopairs.lua       # Auto bracket/quote pairing
  comment.lua         # Commenting
  snippets/           # LuaSnip config and loader
  lualine.lua         # Statusline
  gitsigns.lua        # Git decorations
  nvim_dap.lua        # Debugger (Python/debugpy)
  todo_comments.lua   # Highlighted TODO/FIXME comments
luasnippets/          # LuaSnip snippet files (Python, TeX, Typst, HTML, Lua, Markdown, Shell)
lazy-lock.json        # Plugin lockfile for reproducible installs
```

## Plugins

**LSP & Completion**
- `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig` — LSP management, auto-installs `pyright`, `lua_ls`, `jsonls`, `texlab`
- `none-ls` — formatting via `black` (Python), `prettier` (JS/web), `stylua` (Lua)
- `nvim-cmp` — completion with sources: LSP, buffer, path, cmdline, snippets, spell, tags
- `inc-rename.nvim` — live LSP rename preview

**Debugging**
- `nvim-dap`, `nvim-dap-python`, `nvim-dap-ui` — Python debugging via debugpy (Mason-managed)
- `neotest`, `neotest-python` — test runner integration

**Navigation**
- `telescope.nvim` — fuzzy file finder and live grep
- `nvim-treesitter` — syntax highlighting, folding

**Editing**
- `LuaSnip` — snippet engine with custom snippets
- `nvim-autopairs` — auto-close brackets and quotes
- `Comment.nvim` — line and block commenting

**UI**
- `lualine.nvim` — statusline (seoul256 theme)
- `gitsigns.nvim` — git blame, diff decorations
- `diffview.nvim` — full diff and merge view
- `todo-comments.nvim` — highlighted TODO/FIXME/NOTE markers
- `nvim-web-devicons` — file icons

**LaTeX (optional)**
- `vimtex` — LaTeX compilation, navigation, and Zathura PDF sync

## Keymaps

Leader key: `<Space>` (set in `lua/user/lazy.lua` and `lua/user/keymaps.lua` — change `vim.g.mapleader` there if you want a different key)

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>f` | Fuzzy file finder (Telescope) |
| `<leader>t` | Live grep (Telescope) |
| `<leader>e` | Toggle file explorer (netrw) |

### Editing

| Key | Action |
|-----|--------|
| `<leader>ff` | Format file (none-ls) |
| `<leader>rr` | LSP rename (inc-rename) |
| `<leader>L` | Reload LuaSnip snippets |
| `<A-j/k>` | Move selected lines down/up (visual) |
| `p` (visual) | Paste without overwriting register |

### Debugging

| Key | Action |
|-----|--------|
| `<F5>` | Save all and continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>u` | Evaluate expression |
| `U` | Toggle DAP UI |

### Window resizing

| Key | Action |
|-----|--------|
| `<C-Up/Down>` | Resize horizontal split |
| `<C-Left/Right>` | Resize vertical split |

## Filetype Features

### Python (`ftplugin/python.lua`)
- `py` — runs current file in a horizontal terminal split (25% height)
- `<F9>` — runs current file in a vertical terminal split

### LaTeX (`ftplugin/tex/`) — optional
- `<leader>s` — toggle English spell check (comments excluded)
- `<leader>sd` — toggle German spell check
- German umlaut shortcuts in insert mode: `"a` → `ä`, `"o` → `ö`, `"u` → `ü`, `"s` → `ß` (and uppercase variants)
- Zathura PDF viewer with auto-refocus to Neovim after forward search (requires `xdotool`)

### Text (`ftplugin/text.lua`)
- `<leader>s` / `<leader>sd` — toggle English / German spell check
- Same German umlaut insert-mode shortcuts as LaTeX

## Snippets

Custom LuaSnip snippets in `luasnippets/` for: Python, TeX, Typst, HTML, Lua, Markdown, Shell.

Reload snippets at runtime with `<leader>L`.
