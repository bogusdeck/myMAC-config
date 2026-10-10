#!/bin/zsh

# Directory where your themes are stored
THEME_DIR="$HOME/.config/kitty"

# Find all .conf files that aren't the main config or the current theme
themes=($(ls $THEME_DIR/*.conf | grep -vE "kitty.conf|current-theme.conf|kitty-theme.conf" | xargs -n 1 basename | sed 's/\.conf//'))

# Use fzf to create the dropdown
# --preview: This is the magic. It runs a command every time you move the selection
# --bind: Ensures that when you exit, the last selected theme becomes permanent
selected=$(printf "%s\n" "${themes[@]}" | fzf \
    --height 40% \
    --layout reverse \
    --border \
    --prompt="✨ Select Kitty Theme: " \
    --preview "kitty @ set-colors --all --configured $THEME_DIR/{}.conf" \
    --bind "focus:execute(kitty @ set-colors --all --configured $THEME_DIR/{}.conf)" \
    --preview-window=hidden)

# If a theme was selected (not cancelled with Esc)
if [[ -n "$selected" ]]; then
    ln -sf "$THEME_DIR/$selected.conf" "$THEME_DIR/current-theme.conf"
    # Force kitty to reload the config from the new symlink
    kitty @ set-colors --all --configured "$THEME_DIR/current-theme.conf"
    echo "Successfully switched to $selected"
else
    # If cancelled, revert to the original theme
    kitty @ set-colors --all --configured "$THEME_DIR/current-theme.conf"
fi
