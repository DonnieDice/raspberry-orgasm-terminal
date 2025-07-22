# Detailed Installation Guide

## Prerequisites

Before installing the Raspberry Orgasm Terminal Theme, ensure you have:

1. **Windows 10 version 1903 or later** (Windows 11 recommended)
2. **Administrative privileges** (recommended for full feature set)
3. **Internet connection** (for downloading dependencies)

## Automatic Installation (Recommended)

The easiest way to install is using our automated installer:

```powershell
# One-line install
iwr -useb https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1 | iex

# Or download and run locally
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1" -OutFile "install.ps1"
.\install.ps1
```

### Installer Options

```powershell
# Skip prerequisite installation (if you already have tools installed)
.\install.ps1 -SkipPrerequisites

# Force installation (overwrite without backup)
.\install.ps1 -Force

# Both options
.\install.ps1 -SkipPrerequisites -Force
```

## Manual Installation

If you prefer to install manually or the automatic installer fails:

### Step 1: Install Dependencies

#### Windows Terminal
```powershell
winget install Microsoft.WindowsTerminal
```

#### PowerShell 7
```powershell
winget install Microsoft.PowerShell
```

#### Core Tools
```powershell
# Oh My Posh (prompt theme engine)
winget install JanDeDobbeleer.OhMyPosh

# bat (syntax highlighting for cat)
winget install sharkdp.bat

# glow (markdown renderer)
winget install charmbracelet.glow

# ripgrep (fast search)
winget install BurntSushi.ripgrep

# fzf (fuzzy finder)
winget install junegunn.fzf

# zoxide (smart cd)
winget install ajeetdsouza.zoxide
```

#### Scoop Package Manager
```powershell
# Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iwr -useb get.scoop.sh | iex

# Install Scoop packages
scoop install micro lsd neofetch git delta
```

### Step 2: Download Theme Files

```powershell
# Clone the repository
git clone https://github.com/donniedice/raspberry-orgasm-terminal.git
cd raspberry-orgasm-terminal

# Or download as ZIP
Invoke-WebRequest -Uri "https://github.com/donniedice/raspberry-orgasm-terminal/archive/main.zip" -OutFile "theme.zip"
Expand-Archive -Path "theme.zip" -DestinationPath "."
cd raspberry-orgasm-terminal-main
```

### Step 3: Apply Terminal Settings

```powershell
# Backup existing settings
$terminalPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path "$terminalPath\settings.json") {
    Copy-Item "$terminalPath\settings.json" "$terminalPath\settings.backup.json"
}

# Copy new settings
Copy-Item "config\terminal-settings.json" "$terminalPath\settings.json" -Force
```

### Step 4: Setup PowerShell Profile

```powershell
# Create profile directory
$profileDir = Split-Path $PROFILE -Parent
New-Item -ItemType Directory -Path $profileDir -Force

# Backup existing profile
if (Test-Path $PROFILE) {
    Copy-Item $PROFILE "$profileDir\Microsoft.PowerShell_profile.backup.ps1"
}

# Copy new profile
Copy-Item "config\Microsoft.PowerShell_profile.ps1" $PROFILE -Force

# Copy Oh My Posh theme
Copy-Item "themes\rgx.omp.json" "$env:USERPROFILE\rgx.omp.json" -Force
```

### Step 5: Configure Micro Editor

```powershell
# Create micro config directory
New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\micro" -Force

# Copy micro configurations
Copy-Item "config\micro\*" "$env:USERPROFILE\.config\micro\" -Force -Recurse
```

### Step 6: Setup Admin Terminal Hotkey

```powershell
# Copy scripts
Copy-Item "scripts\OpenAdminTerminal.ps1" "$env:USERPROFILE\" -Force
Copy-Item "scripts\OpenAdminTerminal.vbs" "$env:USERPROFILE\" -Force

# Create shortcut with hotkey
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\OpenAdminTerminal.vbs"
$Shortcut.Hotkey = "CTRL+ALT+T"
$Shortcut.IconLocation = "wt.exe"
$Shortcut.Save()
```

## Post-Installation

### 1. Restart Windows Terminal
Close all Windows Terminal instances and reopen.

### 2. Set PowerShell 7 as Default
In Windows Terminal settings:
1. Open Settings (Ctrl+,)
2. Set default profile to "RGX Mods" or PowerShell 7

### 3. Verify Installation
```powershell
# Check PowerShell version
$PSVersionTable.PSVersion

# Test Oh My Posh
oh-my-posh version

# Test tools
bat --version
glow --version
lsd --version
micro --version
```

### 4. Test Features
- Press `Ctrl+Alt+T` to test admin terminal
- Type `Show-Hotkeys` to see all shortcuts
- Try `z` command for smart navigation
- Test syntax highlighting with `bat README.md`

## Troubleshooting Installation

### "Execution Policy" Error
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### "Command Not Found" Errors
```powershell
# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Or restart PowerShell
```

### Windows Terminal Not Found
Install from Microsoft Store or:
```powershell
winget install Microsoft.WindowsTerminal --source msstore
```

### Fonts Not Displaying Correctly
Windows Terminal should include Cascadia Code. If not:
```powershell
# Install Cascadia Code font
winget install Microsoft.CascadiaCode
```

### Profile Not Loading
Ensure you're using PowerShell 7 (pwsh.exe) not Windows PowerShell 5.1:
```powershell
# Check current shell
$PSVersionTable.PSVersion

# Set pwsh as default in Windows Terminal settings
```

## Uninstallation

To remove the theme:

```powershell
# Restore original terminal settings
$terminalPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path "$terminalPath\settings.backup.json") {
    Copy-Item "$terminalPath\settings.backup.json" "$terminalPath\settings.json" -Force
}

# Restore original PowerShell profile
$profileDir = Split-Path $PROFILE -Parent
if (Test-Path "$profileDir\Microsoft.PowerShell_profile.backup.ps1") {
    Copy-Item "$profileDir\Microsoft.PowerShell_profile.backup.ps1" $PROFILE -Force
}

# Remove theme files
Remove-Item "$env:USERPROFILE\rgx.omp.json" -Force
Remove-Item "$env:USERPROFILE\.config\micro" -Recurse -Force
Remove-Item "$env:USERPROFILE\OpenAdminTerminal.*" -Force
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk" -Force
```

## Support

If you encounter issues:

1. Check [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Search [existing issues](https://github.com/donniedice/raspberry-orgasm-terminal/issues)
3. Create a new issue with:
   - Your Windows version
   - Error messages
   - Installation method used
   - Steps to reproduce