#!/bin/bash

# Raspberry Orgasm Terminal Theme Installer for Linux
set -e
set -o pipefail

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install oh-my-posh if not installed
if ! command_exists oh-my-posh;
    then
    echo "oh-my-posh not found. Installing..."
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
else
    echo "oh-my-posh is already installed."
fi

# Install powerline fonts for proper symbol rendering
echo "Installing powerline fonts for proper symbol rendering..."
if ! command_exists pip3; then
    echo "pip3 not found. Installing python3-pip..."
    sudo apt update && sudo apt install -y python3-pip
fi

# Try to install fonts-powerline package first
if command_exists apt; then
    echo "Installing system powerline fonts..."
    sudo apt install -y fonts-powerline
fi

# If that doesn't work, manually install Cascadia Code
if ! fc-list | grep -i "Cascadia" > /dev/null; then
    echo "Installing Cascadia Code font..."
    wget https://github.com/microsoft/cascadia-code/releases/latest/download/CascadiaCode.zip -O /tmp/CascadiaCode.zip
    unzip -o /tmp/CascadiaCode.zip -d /tmp/cascadia
    mkdir -p "$HOME/.local/share/fonts/"
    cp /tmp/cascadia/ttf/*.ttf "$HOME/.local/share/fonts/" || { echo "Error: Failed to copy fonts"; exit 1; }
    fc-cache -fv || { echo "Error: Failed to cache fonts"; exit 1; }
    echo "Cascadia Code font installed successfully!"
else
    echo "Powerline-capable font already installed."
fi

# Create themes directory
THEMES_DIR="$HOME/.poshthemes"
mkdir -p "$THEMES_DIR"

# Copy themes
if [ -d "themes" ] && [ "$(ls -A themes/*.json 2>/dev/null)" ]; then
    cp themes/*.json "$THEMES_DIR" || { echo "Error: Failed to copy theme files"; exit 1; }
else
    echo "Error: No theme files found in themes/ directory"; exit 1
fi

# Setup Konsole themes if Konsole is installed
if command_exists konsole; then
    echo "Setting up Konsole themes..."
    KONSOLE_DIR="$HOME/.local/share/konsole"
    mkdir -p "$KONSOLE_DIR"
    
    # Copy Konsole theme files if they exist in the repo
    if [ -d "themes/konsole" ]; then
        cp themes/konsole/*.colorscheme "$KONSOLE_DIR/" 2>/dev/null || true
        cp themes/konsole/*.profile "$KONSOLE_DIR/" 2>/dev/null || true
    fi
fi

# Add oh-my-posh to .bashrc
BASHRC_FILE="$HOME/.bashrc"
THEME_PATH="$THEMES_DIR/rgx.omp.json"
INIT_COMMAND="eval \$(oh-my-posh init bash --config '$THEME_PATH')"

if [ ! -f "$BASHRC_FILE" ]; then
    touch "$BASHRC_FILE" || { echo "Error: Cannot create .bashrc"; exit 1; }
fi

if ! grep -q "oh-my-posh init bash" "$BASHRC_FILE";
    then
    echo "Adding oh-my-posh to .bashrc"
    {
        echo ""
        echo "# Initialize Oh My Posh"
        echo "$INIT_COMMAND"
    } >> "$BASHRC_FILE" || { echo "Error: Failed to update .bashrc"; exit 1; }
else
    echo "oh-my-posh is already configured in .bashrc"
fi

# Add Konsole enhancements to .bashrc
if ! grep -q "RGX Mods Konsole Enhancements" "$BASHRC_FILE";
    then
    echo "Adding Konsole enhancements to .bashrc"
    {
        echo ""
        echo "# RGX Mods Konsole Enhancements"
        echo "export TERM=xterm-256color"
        echo "export LANG=en_US.UTF-8"
        echo "export LC_ALL=en_US.UTF-8"
        echo ""
        echo "# RGX Mods Enhanced Tools"
        echo "command -v lsd >/dev/null 2>&1 && alias ls='lsd'"
        echo "command -v bat >/dev/null 2>&1 && alias cat='bat'"
        echo "command -v rg >/dev/null 2>&1 && alias grep='rg'"
    } >> "$BASHRC_FILE" || { echo "Error: Failed to update .bashrc"; exit 1; }
fi

# Set Konsole environment variables in the Konsole profile
if command_exists konsole; then
    KONSOLE_DIR="$HOME/.local/share/konsole"
    if [ -f "$KONSOLE_DIR/rgx.profile" ]; then
        # Ensure TERM environment variable is set in the profile
        if ! grep -q "TERM=xterm-256color" "$KONSOLE_DIR/rgx.profile"; then
            echo "" >> "$KONSOLE_DIR/rgx.profile"
            echo "[Environment]" >> "$KONSOLE_DIR/rgx.profile"
            echo "TERM=xterm-256color" >> "$KONSOLE_DIR/rgx.profile"
        fi
    fi
fi

echo ""
echo "Installation complete!"
echo "Please restart your terminal to see the changes."
echo "For Konsole users, please set the RGX Raspberry profile in Konsole settings."
