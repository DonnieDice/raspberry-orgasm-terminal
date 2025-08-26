#!/bin/bash

# Raspberry Orgasm Terminal Theme Installer for Linux

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

# Install powerline fonts
if [ ! -d "$HOME/.local/share/fonts" ]; then
    mkdir -p "$HOME/.local/share/fonts"
fi

# Try to install fonts-powerline package first
if command_exists apt; then
    sudo apt install -y fonts-powerline
fi

# If that doesn't work, manually install Cascadia Code
if ! fc-list | grep -i "Cascadia" > /dev/null; then
    echo "Installing Cascadia Code font..."
    wget https://github.com/microsoft/cascadia-code/releases/latest/download/CascadiaCode.zip -O /tmp/CascadiaCode.zip
    unzip -o /tmp/CascadiaCode.zip -d /tmp/cascadia
    cp /tmp/cascadia/ttf/*.ttf "$HOME/.local/share/fonts/"
    fc-cache -fv
fi

# Create themes directory
THEMES_DIR="$HOME/.poshthemes"
mkdir -p "$THEMES_DIR"

# Copy themes
cp themes/*.json "$THEMES_DIR"

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
INIT_COMMAND="eval $(oh-my-posh init bash --config '$THEME_PATH')"

if ! grep -q "oh-my-posh init bash" "$BASHRC_FILE";
    then
    echo "Adding oh-my-posh to .bashrc"
    echo "" >> "$BASHRC_FILE"
    echo "# Initialize Oh My Posh" >> "$BASHRC_FILE"
    echo "$INIT_COMMAND" >> "$BASHRC_FILE"
else
    echo "oh-my-posh is already configured in .bashrc"
fi

# Add Konsole enhancements to .bashrc
if ! grep -q "RGX Mods Konsole Enhancements" "$BASHRC_FILE";
    then
    echo "Adding Konsole enhancements to .bashrc"
    echo "" >> "$BASHRC_FILE"
    echo "# RGX Mods Konsole Enhancements" >> "$BASHRC_FILE"
    echo "export TERM=xterm-256color" >> "$BASHRC_FILE"
    echo "export LANG=en_US.UTF-8" >> "$BASHRC_FILE"
    echo "export LC_ALL=en_US.UTF-8" >> "$BASHRC_FILE"
    
    # Add aliases if tools are installed
    echo "" >> "$BASHRC_FILE"
    echo "# RGX Mods Enhanced Tools" >> "$BASHRC_FILE"
    echo "command -v lsd >/dev/null 2>&1 && alias ls='lsd'" >> "$BASHRC_FILE"
    echo "command -v bat >/dev/null 2>&1 && alias cat='bat'" >> "$BASHRC_FILE"
    echo "command -v rg >/dev/null 2>&1 && alias grep='rg'" >> "$BASHRC_FILE"
fi

echo ""
echo "Installation complete!"
echo "Please restart your terminal to see the changes."
echo "For Konsole users, please set the RGX Raspberry profile in Konsole settings."
