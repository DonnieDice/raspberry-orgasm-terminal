#!/bin/bash

# Raspberry Orgasm Terminal Theme Installer for Linux
set -e
set -o pipefail

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect package manager
detect_package_manager() {
    if command_exists apt-get; then
        echo "apt"
    elif command_exists yum; then
        echo "yum"
    elif command_exists pacman; then
        echo "pacman"
    else
        echo "unsupported"
    fi
}

# Function to prompt for sudo password and keep it alive
run_sudo_command() {
    if ! sudo -v; then
        echo "Sudo authentication failed. Exiting."
        exit 1
    fi
    sudo "$@"
}

# Detect package manager
PKG_MANAGER=$(detect_package_manager)

# Install oh-my-posh and powerline fonts
if ! command_exists oh-my-posh; then
    echo "oh-my-posh not found. Installing..."
    case "$PKG_MANAGER" in
        apt)
            run_sudo_command apt-get update
            run_sudo_command apt-get install -y curl unzip powerline-fonts lsd bat ripgrep
            ;;
        yum)
            run_sudo_command yum install -y curl unzip powerline-fonts lsd bat ripgrep
            ;;
        pacman)
            run_sudo_command pacman -Syu --noconfirm curl unzip powerline-fonts lsd bat ripgrep
            ;;
        *)
            echo "Unsupported package manager. Please install curl, unzip, powerline-fonts, lsd, bat, and ripgrep manually."
            exit 1
            ;;
    esac
    curl -s https://ohmyposh.dev/install.sh | run_sudo_command bash -s

else
    echo "oh-my-posh is already installed."
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

# Backup original .bashrc if it exists and hasn't been backed up by this script yet
BASHRC_BACKUP_FILE="$HOME/.bashrc.raspberry_bak"
if [ -f "$BASHRC_FILE" ] && [ ! -f "$BASHRC_BACKUP_FILE" ]; then
    cp "$BASHRC_FILE" "$BASHRC_BACKUP_FILE"
    echo "Backed up original .bashrc to $BASHRC_BACKUP_FILE"
fi

if [ ! -f "$BASHRC_FILE" ]; then
    touch "$BASHRC_FILE" || { echo "Error: Cannot create .bashrc"; exit 1; }
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
        echo "alias ls='lsd'"
        echo "alias cat='bat'"
        echo "alias grep='rg'"
    } >> "$BASHRC_FILE" || { echo "Error: Failed to update .bashrc"; exit 1; }
fi

# Add oh-my-posh to .bashrc (moved to end for precedence)
if ! grep -q "oh-my-posh init bash" "$BASHRC_FILE";
    then
    echo "Adding oh-my-posh to .bashrc"
    {
        echo ""
        echo "# Initialize Oh My Posh"
        echo "echo \"DEBUG: Initializing Oh My Posh...\""
        echo "$INIT_COMMAND"
        echo "INIT_EXIT_CODE=\$?"
        echo "if [ \$INIT_EXIT_CODE -ne 0 ]; then"
        echo "    echo \"DEBUG: Oh My Posh initialization failed with exit code \$INIT_EXIT_CODE\""
        echo "fi"
    } >> "$BASHRC_FILE" || { echo "Error: Failed to update .bashrc"; exit 1; }
else
    echo "oh-my-posh is already configured in .bashrc"
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

        # Attempt to set the RGX Raspberry profile as default in Konsole
        if command_exists kwriteconfig5; then
            echo "Attempting to set RGX Raspberry profile as default in Konsole..."
            # Save current default Konsole profile before changing it
            OLD_KONSOLE_DEFAULT_PROFILE=$(kreadconfig5 --file "$HOME/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" 2>/dev/null || echo "")
            echo "$OLD_KONSOLE_DEFAULT_PROFILE" > "$KONSOLE_DIR/old_default_profile_backup"
            echo "Backed up old Konsole default profile: $OLD_KONSOLE_DEFAULT_PROFILE"
            kwriteconfig5 --file "$HOME/.config/konsolerc" --group "Desktop Entry" --key "DefaultProfile" "rgx.profile" || true
            echo "Konsole default profile set (attempted)."
        else
            echo "kwriteconfig5 not found. Cannot automatically set Konsole default profile."
        fi
    fi
fi

echo ""
echo "Installation complete!"
echo "Please restart your terminal to see the changes."
# Source .bashrc to apply changes immediately if it's an interactive shell
echo "DEBUG: Sourcing .bashrc to apply changes immediately."
[ -f "$BASHRC_FILE" ] && . "$BASHRC_FILE"
