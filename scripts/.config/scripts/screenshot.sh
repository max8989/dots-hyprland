#!/bin/bash
# Screenshot wrapper: copies path to clipboard, then image

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

# Take screenshot with hyprshot (pass all arguments)
hyprshot -o "$SCREENSHOT_DIR" -f "$FILENAME" "$@"

# Check if screenshot was created
if [[ -f "$FILEPATH" ]]; then
    # Copy full path to clipboard (goes to cliphist)
    echo -n "$FILEPATH" | wl-copy
    sleep 0.1
    # Copy image to clipboard (goes to cliphist, now active in clipboard)
    wl-copy < "$FILEPATH"
fi
