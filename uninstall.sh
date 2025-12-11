#!/bin/bash

# Raspberry Orgasm Terminal Theme Uninstaller for Linux
set -e
set -o pipefail

echo "Starting uninstallation for Raspberry Orgasm Terminal Theme..."

# --- 1. Remove oh-my-posh (if installed by this script) ---
echo "Removing oh-my-posh..."
if [ -f "/usr/local/bin/oh-my-posh" ]; then
    sudo rm -f /usr/local/bin/oh-my-posh
    echo "oh-my-posh removed."
else
    echo "oh-my-posh not found or not installed by this script. Skipping."
fi

# --- 2. Remove Cascadia Code Fonts ---
echo "Removing Cascadia Code fonts..."
if [ -d "$HOME/.local/share/fonts/" ]; then
    find "$HOME/.local/share/fonts/" -type f -name "Cascadia*" -delete
    echo "Cascadia Code fonts removed from $HOME/.local/share/fonts/."
fi
# Clean up temporary font files
fc-cache -fv || true # Refresh font cache, ignore errors if no fonts were removed
echo "Font cache refreshed."

# --- 3. Remove Theme Files ---
echo "Removing oh-my-posh theme files..."
THEMES_DIR="$HOME/.poshthemes"
if [ -f "$THEMES_DIR/rgx.omp.json" ]; then
    rm -f "$THEMES_DIR/rgx.omp.json"
    # Remove directory if empty, to be safe.
    rmdir "$THEMES_DIR" 2>/dev/null || true
    echo "Theme file rgx.omp.json removed."
else
    echo "Theme file rgx.omp.json not found. Skipping."
fi

# --- 4. Remove Konsole Theme Files ---
echo "Removing Konsole theme files..."
KONSOLE_DIR="$HOME/.local/share/konsole"
if [ -d "$KONSOLE_DIR" ]; then
    rm -f "$KONSOLE_DIR/rgx.colorscheme" 2>/dev/null || true
    rm -f "$KONSOLE_DIR/rgx.profile" 2>/dev/null || true
    # Attempt to reset Konsole default profile
    if command_exists kwriteconfig5; then
        echo "Attempting to reset Konsole default profile..."
        # Set DefaultProfile to empty string or a known default if you have one
        kwriteconfig5 --file "$HOME/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" "" || true
        echo "Konsole default profile reset (attempted)."
    fi
    # Remove directory if empty, to be safe.
    rmdir "$KONSOLE_DIR" 2>/dev/null || true
    echo "Konsole theme files removed."
else
    echo "Konsole theme directory not found. Skipping."
fi

# --- 5. Revert .bashrc Changes ---
echo "Reverting .bashrc changes..."
BASHRC_FILE="$HOME/.bashrc"
if [ -f "$BASHRC_FILE" ]; then
    # Remove oh-my-posh initialization
    sed -i '/# Initialize Oh My Posh/,/^eval \$(oh-my-posh init bash --config/d' "$BASHRC_FILE" 2>/dev/null || true
    # Remove RGX Mods Konsole Enhancements
    sed -i '/# RGX Mods Konsole Enhancements/,/^command -v rg >\/dev\/null 2>&1 && alias grep='\''rg'\''/d' "$BASHRC_FILE" 2>/dev/null || true
    # Remove remaining empty lines that might have been created
    sed -i '/^$/d' "$BASHRC_FILE" 2>/dev/null || true
    echo ".bashrc changes reverted."
else
    echo ".bashrc not found. Skipping .bashrc changes."
fi

echo "Uninstallation complete!"
echo "Please restart your terminal to see the changes fully applied."

# Source .bashrc to apply changes immediately to the current terminal session
[ -f "$BASHRC_FILE" ] && . "$BASHRC_FILE"
