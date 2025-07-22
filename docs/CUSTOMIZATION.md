# Customization Guide

This guide covers how to customize various aspects of the Raspberry Orgasm Terminal Theme.

## Color Scheme Customization

### Modifying Terminal Colors

Edit the terminal settings file:
```powershell
notepad "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
```

Find the `RGX Raspberry` scheme and modify colors:
```json
{
    "name": "RGX Raspberry",
    "background": "#1f0d24",      // Deep purple-black
    "foreground": "#ffdbe9",      // Light pink
    "red": "#e30b5c",            // RGX Red
    "green": "#c21e56",          // Cranberry
    "yellow": "#ff1744",         // Bright red
    "blue": "#3a2c47",           // Ocean blue
    "purple": "#9d7ba8",         // Purple-grey
    "cyan": "#db2777",           // Pink
    "white": "#ffdbe9",          // Light pink
    // ... more colors
}
```

### PSReadLine Colors

Modify PowerShell syntax highlighting in your profile:
```powershell
notepad $PROFILE
```

Update the color settings:
```powershell
Set-PSReadLineOption -Colors @{
    Command = "#e30b5c"
    Parameter = "#db2777"
    Operator = "#c21e56"
    Variable = "#ec4899"
    String = "#ff4569"
    Number = "#ff1744"
    Type = "#a21caf"
    Comment = "#9d7ba8"
    Keyword = "#00b4d8"
    Error = "DarkRed"
    Selection = "`e[7m"
    InlinePrediction = "#52416b"
}
```

## Prompt Customization

### Modifying the Oh My Posh Theme

Edit the theme file:
```powershell
notepad "$env:USERPROFILE\rgx.omp.json"
```

### Adding Segments

Add new segments to display additional information:
```json
{
    "type": "time",
    "style": "powerline",
    "powerline_symbol": "\uE0B0",
    "foreground": "#ffffff",
    "background": "#663399",
    "properties": {
        "time_format": "15:04:05"
    }
}
```

### Common Segment Types

- `session` - Username/hostname
- `path` - Current directory
- `git` - Git information
- `python` - Python version
- `node` - Node.js version
- `time` - Current time
- `executiontime` - Command duration
- `exit` - Last exit code

### Changing Icons

Modify segment templates:
```json
{
    "type": "git",
    "template": " {{ .HEAD }} ",  // Change git icon
}
```

## Font Customization

### Changing the Terminal Font

In terminal settings:
```json
"font": {
    "face": "Cascadia Code",      // Change font family
    "size": 11,                   // Change font size
    "weight": "normal",           // normal, bold
    "features": {
        "liga": 1                 // Enable ligatures
    }
}
```

### Recommended Fonts

- **Cascadia Code** (default) - Microsoft's terminal font
- **Fira Code** - Popular with ligatures
- **JetBrains Mono** - Excellent readability
- **Hack** - Clean and simple
- **Meslo LG** - Powerline compatible

Install fonts:
```powershell
# Cascadia Code (included with Windows Terminal)
winget install Microsoft.CascadiaCode

# Fira Code
winget install FiraCode

# JetBrains Mono
winget install JetBrains.JetBrainsMono
```

## ASCII Art Customization

### Changing the Welcome Banner

Edit your PowerShell profile:
```powershell
notepad $PROFILE
```

Modify the ASCII art section:
```powershell
Clear-Host
Write-Host ""
Write-Host "Your Custom ASCII Art Here" -ForegroundColor Magenta
Write-Host ""
```

### ASCII Art Generators

- [ASCII Art Generator](https://patorjk.com/software/taag/)
- [Text to ASCII](https://www.ascii-art-generator.org/)
- [FIGlet](http://www.figlet.org/)

## Alias Customization

### Adding Custom Aliases

Add to your profile:
```powershell
# Custom aliases
Set-Alias -Name g -Value git
Set-Alias -Name py -Value python
Set-Alias -Name n -Value notepad

# Custom functions
function dev { cd "C:\Development" }
function proj { cd "C:\Projects\$args" }
function clean { Clear-RecycleBin -Force }
```

### Git Aliases

Extend git shortcuts:
```powershell
function gco { param($branch) git checkout $branch }
function gb { git branch }
function gd { git diff }
function gpl { git pull }
function grs { git reset --hard }
```

## Transparency and Effects

### Window Transparency

Adjust in terminal settings:
```json
"useAcrylic": true,           // Enable transparency
"acrylicOpacity": 0.9,        // 0.0 (transparent) to 1.0 (opaque)
```

### Background Image

Add a background image:
```json
"backgroundImage": "C:\\Path\\To\\Your\\Image.jpg",
"backgroundImageOpacity": 0.3,
"backgroundImageStretchMode": "uniformToFill"
```

Stretch modes:
- `none` - No stretching
- `fill` - Fill without maintaining aspect ratio
- `uniform` - Maintain aspect ratio, fit within
- `uniformToFill` - Maintain aspect ratio, fill

## Keybinding Customization

### Adding Custom Keybindings

Add to terminal settings:
```json
"keybindings": [
    {
        "command": "duplicatePane",
        "keys": "ctrl+shift+d"
    },
    {
        "command": {
            "action": "sendInput",
            "input": "clear\r"
        },
        "keys": "ctrl+k"
    }
]
```

### Common Custom Bindings

```json
// Quick commands
{ "command": { "action": "sendInput", "input": "git status\r" }, "keys": "ctrl+g" },
{ "command": { "action": "sendInput", "input": "ls -la\r" }, "keys": "ctrl+alt+l" },

// Navigation
{ "command": "nextTab", "keys": "ctrl+pgdn" },
{ "command": "prevTab", "keys": "ctrl+pgup" },

// Pane management
{ "command": "togglePaneZoom", "keys": "ctrl+shift+z" },
{ "command": { "action": "swapPane", "direction": "left" }, "keys": "ctrl+shift+left" }
```

## Performance Optimization

### Disable Animations

For better performance:
```powershell
# In profile
$PSStyle.Progress.View = 'Minimal'
```

### Limit History

```powershell
Set-PSReadLineOption -MaximumHistoryCount 1000
```

### Disable Unused Features

Comment out in profile:
```powershell
# Invoke-Expression (...) for unused tools
# Import-Module ... for unused modules
```

## Creating Color Themes

### Theme Template

Create new color schemes:
```json
{
    "name": "My Custom Theme",
    "background": "#000000",
    "foreground": "#ffffff",
    "red": "#ff0000",
    "green": "#00ff00",
    "yellow": "#ffff00",
    "blue": "#0000ff",
    "purple": "#ff00ff",
    "cyan": "#00ffff",
    "white": "#ffffff",
    "brightBlack": "#808080",
    "brightRed": "#ff8080",
    "brightGreen": "#80ff80",
    "brightYellow": "#ffff80",
    "brightBlue": "#8080ff",
    "brightPurple": "#ff80ff",
    "brightCyan": "#80ffff",
    "brightWhite": "#ffffff"
}
```

### Theme Resources

- [Windows Terminal Themes](https://windowsterminalthemes.dev/)
- [Terminal.Sexy](https://terminal.sexy/)
- [ColorHunt](https://colorhunt.co/)

## Backup and Restore

### Backup Current Setup

```powershell
# Create backup directory
$backupDir = "$env:USERPROFILE\TerminalBackup_$(Get-Date -Format 'yyyyMMdd')"
New-Item -ItemType Directory -Path $backupDir -Force

# Backup files
Copy-Item $PROFILE "$backupDir\"
Copy-Item "$env:USERPROFILE\rgx.omp.json" "$backupDir\"
Copy-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "$backupDir\"
```

### Restore from Backup

```powershell
# Restore files
$backupDir = "$env:USERPROFILE\TerminalBackup_20240101"
Copy-Item "$backupDir\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
Copy-Item "$backupDir\rgx.omp.json" "$env:USERPROFILE\" -Force
Copy-Item "$backupDir\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" -Force
```

## Sharing Your Customizations

### Export Theme

Create a shareable theme package:
```powershell
# Create export
$exportDir = "$env:USERPROFILE\MyThemeExport"
New-Item -ItemType Directory -Path $exportDir -Force

# Copy customized files
Copy-Item $PROFILE "$exportDir\profile.ps1"
Copy-Item "$env:USERPROFILE\*.omp.json" "$exportDir\"

# Create install script
@'
# Install script for custom theme
Copy-Item "profile.ps1" $PROFILE -Force
Copy-Item "*.omp.json" "$env:USERPROFILE\" -Force
Write-Host "Theme installed! Restart terminal."
'@ | Out-File "$exportDir\install.ps1"
```

## Advanced Customizations

### Custom PowerShell Modules

Create reusable modules:
```powershell
# Create module directory
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\PowerShell\Modules\MyTools" -Force

# Create module
@'
function Get-MyTools {
    # Your custom tools
}
Export-ModuleMember -Function Get-MyTools
'@ | Out-File "$env:USERPROFILE\Documents\PowerShell\Modules\MyTools\MyTools.psm1"

# Import in profile
Import-Module MyTools
```

### Dynamic Prompts

Create context-aware prompts:
```powershell
# Add to Oh My Posh theme
{
    "type": "command",
    "style": "powerline",
    "foreground": "#ffffff",
    "background": "#ff0000",
    "properties": {
        "command": "if ($env:VIRTUAL_ENV) { 'VENV' } else { '' }"
    }
}
```