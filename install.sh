#!/usr/bin/env bash
set -euo pipefail

info() { echo "[info]  $*"; }
die()  { echo "[error] $*" >&2; exit 1; }

# --- System deps -------------------------------------------------------------

info "Installing system dependencies..."
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y git curl unzip nodejs npm python3 pipx neovim ripgrep

# --- black -------------------------------------------------------------------

info "Installing black..."
pipx install black
pipx ensurepath

# --- prettier ----------------------------------------------------------------

info "Installing prettier..."
npm config set prefix ~/.local
npm install -g prettier

# --- stylua ------------------------------------------------------------------

info "Installing stylua..."
STYLUA_VERSION=$(curl -s https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest \
    | grep '"tag_name"' | grep -oP 'v[\d.]+')
curl -sLo /tmp/stylua.zip \
    "https://github.com/JohnnyMorganz/StyLua/releases/download/${STYLUA_VERSION}/stylua-linux-x86_64.zip"
unzip -o /tmp/stylua.zip stylua -d /tmp/
sudo mv /tmp/stylua /usr/local/bin/stylua
sudo chmod +x /usr/local/bin/stylua
rm /tmp/stylua.zip
info "stylua ${STYLUA_VERSION} installed."

# --- win32yank (WSL clipboard bridge) ----------------------------------------

if grep -qi microsoft /proc/version 2>/dev/null; then
    if ! command -v win32yank.exe &>/dev/null; then
        info "WSL detected — installing win32yank for clipboard support..."
        curl -sLo /tmp/win32yank.zip \
            "https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip"
        unzip -o /tmp/win32yank.zip win32yank.exe -d /tmp/
        sudo mv /tmp/win32yank.exe /usr/local/bin/
        rm /tmp/win32yank.zip
        info "win32yank installed."
    else
        info "win32yank already installed, skipping."
    fi
fi

# --- Done --------------------------------------------------------------------

info "Done. Launch nvim — lazy.nvim will bootstrap and install all plugins on first launch."
info "Mason will auto-install LSP servers (pyright, lua_ls, jsonls) on first launch."
