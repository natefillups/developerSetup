# Keyboard Setup
`hidutil property --set '{"UserKeyMapping":[     {         "HIDKeyboardModifierMappingSrc": 0x700000065,         "HIDKeyboardModifierMappingDst": 0x7000000E6 } ]}'`


# developerSetup
Setup for my neovim, tmux, and ohmyzsh preferences

## Install HomeBrew and its Components
- [HomeBrew](https://brew.sh)
- [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh)
- [Tmux](https://github.com/tmux/tmux)
- [Neovim](https://github.com/neovim/neovim)

### Install NerdFonts
- [NerdFonts](https://github.com/ryanoasis/nerd-fonts)
- Next setup the CaskaydiaCove Nerd Font (Font size 16)

### OhMyZsh Setup
- Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Enter the `~/.zshrc` file and change the `ZSH_THEME` to `powerlevel10k/powerlevel10k`
- Use the command `source ~/.zshrc` to initialize the setup.

- Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- Add `zsh-autosuggestions zsh-syntax-highlighting web-search` to the `plugins` in the `~/.zshrc` file

### NeoVim Setup
- `brew install neovim`

