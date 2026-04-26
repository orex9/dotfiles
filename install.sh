#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Ensure we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script is designed for macOS. Detected: $OSTYPE"
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

backup() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        info "Backing up $target -> $BACKUP_DIR"
        cp -R "$target" "$BACKUP_DIR/"
        rm -rf "$target"
    elif [[ -L "$target" ]]; then
        info "Removing old symlink $target"
        rm "$target"
    fi
}

link_file() {
    local src="$1"
    local dst="$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"

    if [[ ! -e "$src" ]]; then
        warn "Source file does not exist: $src"
        return 1
    fi

    mkdir -p "$dst_dir"

    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        success "Already linked: $dst"
        return 0
    fi

    backup "$dst"
    ln -s "$src" "$dst"
    success "Linked: $dst -> $src"
}

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    success "Homebrew already installed"
fi

# Ensure brew is in PATH for this script
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Brew bundle ---
if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
    info "Running brew bundle..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
else
    warn "No Brewfile found in $DOTFILES_DIR"
fi

# --- Oh My Zsh ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    success "Oh My Zsh already installed"
fi

# --- Zsh plugins ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
else
    success "zsh-autosuggestions already installed"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
else
    success "zsh-syntax-highlighting already installed"
fi

# --- Symlinks ---
info "Setting up dotfile symlinks..."

link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link_file "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# --- Neovim (bob) ---
if command -v bob &>/dev/null; then
    if ! command -v nvim &>/dev/null || ! nvim --version | head -1 | grep -q "nightly"; then
        info "Installing Neovim nightly via bob..."
        bob install nightly
        bob use nightly
    else
        success "Neovim nightly already installed"
    fi
else
    warn "bob not found. Skipping Neovim installation."
fi

# --- GohuFont for Ghostty ---
FONT_NAME="GohuFont uni14 Nerd Font Mono"
if ! fc-list | grep -qi "$FONT_NAME" 2>/dev/null || ! ls ~/Library/Fonts/ | grep -qi "Gohu" 2>/dev/null; then
    info "Installing GohuFont..."
    TMP_DIR="$(mktemp -d)"
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip" -o "$TMP_DIR/Gohu.zip"
    unzip -o "$TMP_DIR/Gohu.zip" -d "$TMP_DIR/GohuFont"
    cp "$TMP_DIR"/GohuFont/*.ttf ~/Library/Fonts/ 2>/dev/null || true
    rm -rf "$TMP_DIR"
    success "GohuFont installed"
else
    success "GohuFont already installed"
fi

# --- Post-install reminders ---
echo ""
echo -e "${GREEN}=== Dotfiles installation complete! ===${NC}"
echo ""

if [[ -n "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]]; then
    warn "Existing files were backed up to: $BACKUP_DIR"
fi

if ! echo "$PATH" | grep -q "nvim-bin"; then
    warn "Make sure ~/.local/share/bob/nvim-bin is in your PATH."
    warn "It should be handled by the .zshrc, but you may need to restart your shell."
fi

info "Manual steps you may still need:"
echo "  1. Set your terminal (Ghostty) font to 'GohuFont uni14 Nerd Font Mono'"
echo "  2. Restart your terminal or run: source ~/.zshrc"
echo "  3. Open nvim to let it install plugins (if needed)"
echo "  4. For blink.cmp, download the .dylib from https://github.com/Saghen/blink.cmp/releases"
echo "     and place it in ~/.local/share/nvim/site/pack/core/opt/blink.cmp/target/release"
echo ""
