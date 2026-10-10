# 🖥️ myMAC-config

Personal macOS dotfiles and workflow configuration tailored for an Arch + Hyprland tiling desktop experience.

---

## 📦 What's Included

| Folder / File | Description |
| :--- | :--- |
| **`aerospace/`** | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager config configured with Arch Hyprland keybindings & workflow |
| **`kitty/`** | [Kitty](https://sw.kovidgoyal.net/kitty/) terminal config with dark themes, session scripts, and shell integration |
| **`nvim/`** | [Neovim](https://neovim.io/) configuration (LazyVim, plugins, keymaps, LSP) |
| **`zsh/`** | `.zshrc` configuration with zplug, fzf, paths, and secret separation |
| **`starship/`** | [Starship](https://starship.rs/) cross-shell prompt config |
| **`git/`** | Global `.gitconfig` settings |
| **`Brewfile`** | Snapshot of all Homebrew formulae, casks (GUI apps), and taps |
| **`install.sh`** | Automated symlinking script for setup on new systems |

---

## ⚡ Quick Install

```bash
# 1. Clone repository
git clone git@github.com:bogusdeck/myMAC-config.git ~/myMAC-config

# 2. Run symlink installer
cd ~/myMAC-config
chmod +x install.sh
./install.sh

# 3. (Optional) Install all Homebrew packages & apps
brew bundle --file=Brewfile
```

---

## 🔒 Secret Management

Private API keys and local tokens are isolated in `~/.zshrc.local` (which is gitignored):
```bash
cp zsh/.zshrc.local.example ~/.zshrc.local
# Edit ~/.zshrc.local with your private keys
```
