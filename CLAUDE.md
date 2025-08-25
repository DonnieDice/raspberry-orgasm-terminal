# Raspberry Orgasm Terminal - Claude Assistant Guide

## Project Overview
Terminal theme for Windows PowerShell with rich burgundy/cranberry aesthetic and extensive customization.

## Key Features
- Rich HTML copy/paste formatting
- Syntax highlighting with bat
- Markdown rendering with glow
- Single-line powerline prompt
- Custom raspberry/burgundy color scheme
- Micro editor with nano-style keybindings
- Advanced hotkey integration
- Zoxide smart directory navigation
- FZF fuzzy finding
- Git integration

## Color Palette
- Background: #1f0d24 (deep purple-black)
- Foreground: #ffdbe9 (light pink)
- RGX Red: #e30b5c (primary accent)
- Cranberry: #c21e56 (secondary accent)
- Deep Pink: #8b2252 (tertiary accent)
- Purple-Grey: #9d7ba8 (final accent)
- Ocean Blue: #3a2c47 (highlight)

## Installation
One-line install:
```powershell
iwr -useb https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1 | iex
```

## Project Structure
- /config/ - Terminal and editor configurations
- /themes/ - Oh-My-Posh theme files
- /scripts/ - PowerShell scripts
- /docs/ - Documentation
- /wiki/ - Wiki pages
- /assets/ - Images and resources

## Universal Text Banner
```
═══════════════════════════════════════════════════════
       RASPBERRY ORGASM TERMINAL THEME
       RGX MODS by RealmGX
═══════════════════════════════════════════════════════
```

## Development Commands
- Test theme: `oh-my-posh init pwsh --config themes/rgx.omp.json | Invoke-Expression`
- Reload profile: `. $PROFILE`
- Check git status: `git status`
- Build and deploy: Follow standard git workflow

## Key Files
- terminal-settings.json - Main terminal configuration
- rgx.omp.json - Oh-My-Posh theme
- Microsoft.PowerShell_profile.ps1 - PowerShell profile
- install.ps1 - Installation script

## Testing
Always test changes by:
1. Reloading PowerShell profile
2. Testing hotkeys
3. Verifying color rendering
4. Checking prompt display
5. Testing copy/paste functionality