#!/usr/bin/env bash
# ==============================================================================
# myMAC-config install & symlink script
# ==============================================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Installing macOS dotfiles from $DOTFILES_DIR..."

# Ensure target directories exist
mkdir -p ~/.config/kitty
mkdir -p ~/.config/nvim

# Backup helper
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "📦 Backing up existing $target -> ${target}.backup"
        mv "$target" "${target}.backup"
    fi
}

# 1. AeroSpace
backup_if_exists ~/.aerospace.toml
ln -sf "$DOTFILES_DIR/aerospace/aerospace.toml" ~/.aerospace.toml
echo "✅ AeroSpace linked (~/.aerospace.toml)"

# 2. Zsh
backup_if_exists ~/.zshrc
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
echo "✅ Zsh linked (~/.zshrc)"

# Create ~/.zshrc.local if missing
if [ ! -f ~/.zshrc.local ]; then
    cp "$DOTFILES_DIR/zsh/.zshrc.local.example" ~/.zshrc.local
    echo "💡 Created ~/.zshrc.local from template (add your private API keys here)"
fi

# 3. Kitty
backup_if_exists ~/.config/kitty
ln -sfn "$DOTFILES_DIR/kitty" ~/.config/kitty
echo "✅ Kitty linked (~/.config/kitty)"

# 4. Neovim
backup_if_exists ~/.config/nvim
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
echo "✅ Neovim linked (~/.config/nvim)"

# 5. Starship
backup_if_exists ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml
echo "✅ Starship linked (~/.config/starship.toml)"

# 6. Git
backup_if_exists ~/.gitconfig
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
echo "✅ Git linked (~/.gitconfig)"

# 7. Zed
mkdir -p ~/.config/zed
backup_if_exists ~/.config/zed/settings.json
backup_if_exists ~/.config/zed/keymap.json
ln -sf "$DOTFILES_DIR/zed/settings.json" ~/.config/zed/settings.json
ln -sf "$DOTFILES_DIR/zed/keymap.json" ~/.config/zed/keymap.json
echo "✅ Zed linked (~/.config/zed)"

# 8. Ranger
backup_if_exists ~/.config/ranger
ln -sfn "$DOTFILES_DIR/ranger" ~/.config/ranger
echo "✅ Ranger linked (~/.config/ranger)"

echo ""
echo "🎉 All dotfiles linked successfully!"
echo "To install all Homebrew apps and dependencies, run:"
echo "   brew bundle --file=$DOTFILES_DIR/Brewfile"
