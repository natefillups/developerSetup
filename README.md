# Developer Setup

Setup for my neovim, kitty, and ohmyzsh preferences.

## Quick Start

```bash
git clone <repo-url> ~/Developer/developerSetup
cd ~/Developer/developerSetup
./install.sh
```

The install script installs Homebrew packages from the Brewfile, sets up Oh My Zsh with plugins, and symlinks configs to the right places. If existing configs are found, they're backed up to `*.bak`.

## Keyboard Remap

```bash
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc": 0x700000065,"HIDKeyboardModifierMappingDst": 0x7000000E6}]}'
```

## Prerequisites

### Homebrew

- [Homebrew](https://brew.sh)

### Terminal & Shell

- [Kitty](https://sw.kovidgoyal.net/kitty/) — `brew install --cask kitty`
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Neovim

- `brew install neovim`
- Plugins are managed via [lazy.nvim](https://github.com/folke/lazy.nvim) and install automatically on first launch.
- After first launch, run `:call coc#util#install()` inside nvim to finish CoC setup.

### Fonts

- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) — CaskaydiaCove Nerd Font Mono

## Structure

```
├── install.sh              # Installs packages & symlinks configs
├── Brewfile                # Homebrew packages & casks
├── config/
│   ├── nvim/               # → ~/.config/nvim
│   ├── kitty/              # → ~/.config/kitty
│   ├── git/                # → ~/.config/git (gitconfig + global gitignore)
│   └── zshrc               # → ~/.zshrc
└── archive/                # Old configs kept for reference
    └── tmux.conf
```
