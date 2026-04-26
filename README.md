# dotfiles

## Quick install on a new Mac

```sh
git clone https://github.com/oreliyahu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The `install.sh` script will:
- Install Homebrew (if missing)
- Run `brew bundle`
- Install Oh My Zsh and zsh plugins
- Install Neovim nightly via `bob`
- Symlink all dotfiles (with backups of any existing files)
- Install GohuFont

## Manual steps

If you prefer to do things manually, the steps are below.

Requires [Homebrew](https://brew.sh). Install it first if you don't have it:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Brew bundle

Install all Homebrew dependencies from the Brewfile:

```sh
brew bundle
```

### bob + neovim nightly

[bob](https://github.com/MordechaiHadad/bob) is a Neovim version manager. It is installed via `brew bundle` above.

```sh
bob install nightly
bob use nightly
```

> Make sure `~/.local/share/bob/nvim-bin` is in your `$PATH`.

### oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### zsh-autosuggestions
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### GohuFont (for Ghostty)

Download and install the [GohuFont Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip):

```sh
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip -o Gohu.zip
unzip Gohu.zip -d GohuFont
cp GohuFont/*.ttf ~/Library/Fonts/
rm -rf Gohu.zip GohuFont
```
