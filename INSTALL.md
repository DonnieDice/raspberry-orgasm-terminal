# Installation Guide - Raspberry Orgasm Terminal Theme

## Prerequisites

Before installing, ensure you have:
- Windows 10 version 1903 or later
- Administrator access (recommended)
- Internet connection for downloading packages

## Quick Install (Recommended)

Open PowerShell as Administrator and run:

```powershell
iwr -useb https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1 | iex
```

This will:
1. Install all required tools
2. Configure Windows Terminal
3. Set up PowerShell profile
4. Configure hotkeys

## Manual Installation

### Step 1: Install Core Components

```powershell
# Install Windows Terminal
winget install Microsoft.WindowsTerminal

# Install PowerShell 7
winget install Microsoft.PowerShell

# Install Oh My Posh
winget install JanDeDobbeleer.OhMyPosh
```

### Step 2: Install Additional Tools

```powershell
# Install syntax highlighting and utilities
winget install sharkdp.bat
winget install charmbracelet.glow
winget install BurntSushi.ripgrep
winget install junegunn.fzf
winget install ajeetdsouza.zoxide
winget install dandavison.delta

# Install Scoop package manager
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iwr -useb get.scoop.sh | iex

# Install Scoop packages
scoop install micro lsd neofetch git
```

### Step 3: Configure Windows Terminal

1. Open Windows Terminal Settings (Ctrl+,)
2. Click "Open JSON file" in bottom left
3. Replace contents with [terminal-settings.json](config/terminal-settings.json)

### Step 4: Configure PowerShell Profile

1. Create profile directory:
```powershell
New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force
```

2. Copy profile:
```powershell
Copy-Item config\Microsoft.PowerShell_profile.ps1 $PROFILE -Force
```

3. Copy theme:
```powershell
Copy-Item themes\rgx.omp.json $env:USERPROFILE\rgx.omp.json -Force
```

### Step 5: Configure Micro Editor

```powershell
# Create config directory
New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\micro" -Force

# Copy configurations
Copy-Item config\micro\* "$env:USERPROFILE\.config\micro\" -Force -Recurse
```

### Step 6: Set Up Admin Hotkey

```powershell
# Copy scripts
Copy-Item scripts\OpenAdminTerminal.ps1 $env:USERPROFILE\ -Force
Copy-Item scripts\OpenAdminTerminal.vbs $env:USERPROFILE\ -Force

# Create shortcut
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\OpenAdminTerminal.vbs"
$Shortcut.Hotkey = "CTRL+ALT+T"
$Shortcut.IconLocation = "wt.exe"
$Shortcut.Save()
```

## Post-Installation

### Verify Installation

1. Close and reopen Windows Terminal
2. You should see the Raspberry Orgasm ASCII art
3. Test commands:
```powershell
bat --version
glow --version
micro --version
```

### Set PowerShell 7 as Default

1. Open Windows Terminal Settings
2. Set default profile to "RGX Mods" or PowerShell 7

### Font Installation (Optional)

For best results, install a Nerd Font:
1. Download [CascadiaCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases)
2. Install the font
3. Update Terminal settings to use "CaskaydiaCove Nerd Font"

## Troubleshooting

### Installation Fails

If the automatic installer fails:
1. Run PowerShell as Administrator
2. Set execution policy: `Set-ExecutionPolicy RemoteSigned -Force`
3. Try manual installation steps

### Missing Icons/Symbols

Install a Nerd Font as described above.

### Commands Not Found

Ensure tools are in PATH:
```powershell
refreshenv
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

### Profile Not Loading

Check profile location:
```powershell
Test-Path $PROFILE
$PROFILE
```

## Uninstallation

To remove the theme:
```powershell
# Restore default profile
Remove-Item $PROFILE -Force

# Remove theme file
Remove-Item "$env:USERPROFILE\rgx.omp.json" -Force

# Reset Terminal settings
# Open Terminal Settings and click "Reset to defaults"
```

## Updating

To update to the latest version:
```powershell
# Re-run installer with -Force flag
iwr -useb https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1 | iex
```

## Need Help?

- Check [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)
- Open an [issue](https://github.com/donniedice/raspberry-orgasm-terminal/issues)
- Review [documentation](docs/)