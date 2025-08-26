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

# Create themes directory
THEMES_DIR="$HOME/.poshthemes"
mkdir -p "$THEMES_DIR"

# Copy themes
cp themes/*.json "$THEMES_DIR"

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

echo ""
echo "Installation complete!"
echo "Restart your terminal to see the changes."
