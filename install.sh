#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="${HOME}/.config"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()  { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[SKIP]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

link_config() {
    local src="$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        local current_target
        current_target="$(readlink "$dest")"
        if [ "$current_target" = "$src" ]; then
            info "$dest already linked"
            return
        fi
        warn "$dest is a symlink to $current_target — replacing"
        rm "$dest"
    elif [ -e "$dest" ]; then
        warn "$dest exists — backing up to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    info "$dest → $src"
}

clone_if_missing() {
    local repo="$1"
    local dest="$2"

    if [ -d "$dest" ]; then
        info "$dest already exists"
    else
        git clone "$repo" "$dest"
        info "Cloned $repo"
    fi
}

echo ""
echo "=== Developer Setup Installer ==="
echo ""

# Brew packages
if command -v brew &>/dev/null; then
    echo "Installing Homebrew packages..."
    brew bundle --file="${DOTFILES_DIR}/Brewfile"
    info "Homebrew packages installed"
else
    error "Homebrew not found — install it from https://brew.sh"
    exit 1
fi

# Oh My Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    info "Oh My Zsh installed"
else
    info "Oh My Zsh already installed"
fi

# Zsh plugins & theme
clone_if_missing "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM}/themes/powerlevel10k"
clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting" "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

# Neovim
link_config "${DOTFILES_DIR}/config/nvim" "${CONFIG_DIR}/nvim"

# CoC extensions
link_config "${DOTFILES_DIR}/config/coc/extensions/package.json" "${CONFIG_DIR}/coc/extensions/package.json"
(cd "${CONFIG_DIR}/coc/extensions" && npm install)
info "CoC extensions installed"

# Kitty
link_config "${DOTFILES_DIR}/config/kitty" "${CONFIG_DIR}/kitty"

# Git
link_config "${DOTFILES_DIR}/config/git" "${CONFIG_DIR}/git"

# Zsh
link_config "${DOTFILES_DIR}/config/zshrc" "${HOME}/.zshrc"

echo ""
echo "Done! You may need to restart your shell and kitty for changes to take effect."
echo "  - Run 'p10k configure' to set up your Powerlevel10k prompt."
echo "  - Open nvim and run ':Lazy sync' to install plugins."
echo "  - Set your git identity: git config --global user.name 'Your Name' && git config --global user.email 'you@example.com'"
