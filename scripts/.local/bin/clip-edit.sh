#!/bin/bash
# =====================================================================
# CLIPBOARD EDITOR (ROFI + FLOATING TERMINAL)
# =====================================================================

# 1. Open Rofi to select an item from the clipboard history
SELECTED=$(cliphist list | rofi -dmenu -p "󰏫 " -theme ~/.config/rofi/clipboard.rasi)

# Exit if nothing was selected
if [ -z "$SELECTED" ]; then
    exit 0
fi

# Exit if the selected item is an image (binary data)
if [[ "$SELECTED" == *"[["*"binary data"*"]]"* ]]; then
    notify-send "Clipboard" "Cannot edit binary data (images)!"
    exit 1
fi

# 2. Decode the full text and save it to a temporary file
TEMP_FILE=$(mktemp) # Create a temporary file (es. /tmp/tmp.aBcD123)
echo "$SELECTED" | cliphist decode > "$TEMP_FILE"

# 3. Open Kitty as a floating window using the 'nano' text editor
# (We reuse the 'floating_update' class you already configured in Hyprland)
kitty --class floating-tui -o remember_window_size=no -o initial_window_width=850 -o initial_window_height=550 -e nvim -n "$TEMP_FILE"

# 4. Once Kitty is closed, copy the newly edited text to the clipboard, then delete the temporary file
wl-copy < "$TEMP_FILE"
rm "$TEMP_FILE"

# Optional: Send a notification
notify-send "Clipboard" "Text edited and copied!"
