#!/bin/bash

# Raspberry Orgasm Terminal Theme Installer for Linux
set -e
set -o pipefail

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt for sudo password and keep it alive
run_sudo_command() {
    local cmd="$@"
    local MAX_SUDO_ATTEMPTS=3
    for (( i=1; i<=MAX_SUDO_ATTEMPTS; ++i )); do
        if sudo -v; then # Check if sudo credentials are valid
            echo "Running: $cmd"
            if $cmd; then # Execute the actual command
                return 0
            else
                echo "Command '$cmd' failed."
                return 1
            fi
        else
            echo "Sudo authentication failed (attempt $i/$MAX_SUDO_ATTEMPTS)."
            if [ $i -eq $MAX_SUDO_ATTEMPTS ]; then
                echo "Max sudo attempts reached. Exiting."
                exit 1
            fi
            sleep 1 # Small delay before next prompt
        fi
    done
}

# Install oh-my-posh if not installed
if ! command_exists oh-my-posh; then
    echo "oh-my-posh not found. Installing..."
    MAX_RETRIES=5
    RETRY_DELAY_SECONDS=5
    for i in $(seq 1 $MAX_RETRIES); do
        echo "Attempt $i/$MAX_RETRIES: Downloading oh-my-posh..."
        if run_sudo_command wget --tries=1 --timeout=20 https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh; then
            echo "oh-my-posh downloaded successfully."
            break
        else
            echo "Download failed. Retrying in $RETRY_DELAY_SECONDS seconds..."
            sleep $RETRY_DELAY_SECONDS
        fi
        if [ $i -eq $MAX_RETRIES ]; then
            echo "Failed to download oh-my-posh after $MAX_RETRIES attempts."
            exit 1
        fi
    done
    run_sudo_command chmod +x /usr/local/bin/oh-my-posh
    touch "$HOME/.local/share/raspberry-orgasm-terminal_oh_my_posh_installed_by_us"
    echo "Flag file created: Oh My Posh installed by this script."
    oh-my-posh --version
else
    echo "oh-my-posh is already installed."
fi

# Install powerline fonts for proper symbol rendering
echo "Installing powerline fonts for proper symbol rendering..."
if ! command_exists pip3; then
    echo "pip3 not found. Installing python3-pip..."
    run_sudo_command apt update && run_sudo_command apt install -y python3-pip
fi

# Try to install fonts-powerline package first
if command_exists apt; then
    echo "Installing system powerline fonts..."
    run_sudo_command apt install -y fonts-powerline
fi

# If that doesn't work, install packaged Cascadia Code Nerd Font
if ! fc-list | grep -i "Cascadia" > /dev/null; then
    echo "Installing Cascadia Code Nerd Font..."
    mkdir -p "$HOME/.local/share/fonts/"
    cp "fonts/cascadia-code/"*.ttf "$HOME/.local/share/fonts/" || { echo "Error: Failed to copy fonts"; exit 1; }
    fc-cache -fv || { echo "Error: Failed to cache fonts"; exit 1; }
    echo "Cascadia Code Nerd Font installed successfully!"
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
        echo "command -v lsd >/dev/null 2>&1 && alias ls='lsd'"
        echo "command -v bat >/dev/null 2>&1 && alias cat='bat'"
        echo "command -v rg >/dev/null 2>&1 && alias grep='rg'"
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
