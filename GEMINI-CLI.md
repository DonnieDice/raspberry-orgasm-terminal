# Raspberry Orgasm Terminal - Gemini CLI Assistant Guide

## Project Overview
Terminal theme for Windows PowerShell and Linux bash with rich burgundy/cranberry aesthetic and extensive customization.

## Key Features
- Rich HTML copy/paste formatting
- Syntax highlighting with bat
- Markdown rendering with glow
- Enhanced powerline prompt with proper segment coloring
- Custom raspberry/burgundy color scheme
- Micro editor with nano-style keybindings
- Advanced hotkey integration
- Zoxide smart directory navigation
- FZF fuzzy finding
- Git integration
- Cross-platform support (Windows PowerShell, Linux bash, Konsole terminal)

## Repository Organization (100x Premium Optimization)

### Root Directory
```
raspberry-orgasm-terminal/
├── assets/              # Branding assets and media
├── config/              # Terminal and editor configurations
├── docs/                # Detailed documentation
├── scripts/             # Utility scripts
├── test/                # Verification and testing scripts
├── themes/              # Oh-My-Posh theme files
├── wiki/                # Extended documentation and guides
├── .claude/             # Claude-specific settings
├── .gitignore           # Git ignore patterns
├── CLAUDE.md            # Claude-specific project guide
├── CONTRIBUTING.md      # Contribution guidelines
├── CONTRIBUTORS.md      # Contributor acknowledgments
├── index.js             # Cross-platform installer entry point
├── INSTALL.md           # Installation instructions
├── install.ps1          # Windows PowerShell installer
├── install.sh           # Linux bash installer
├── KONSOLE-THEME-SUMMARY.md # Konsole theming implementation details
├── LICENSE              # MIT License
├── package.json         # Node.js package configuration
├── POWERLINE-ENHANCEMENT-SUMMARY.md # Powerline enhancement details
├── QWEN.md              # Qwen-specific project analysis
├── README.md            # Main project documentation
└── GEMINI-CLI.md        # This file - Gemini CLI project guide
```

### Key Directories Breakdown

#### /assets/
- Branding images and resources
- Project banner and icons

#### /config/
- Microsoft.PowerShell_profile.ps1 - PowerShell profile configuration
- terminal-settings.json - Main terminal configuration
- terminal-settings-simple.json - Simplified terminal configuration
- /micro/ - Micro editor settings

#### /docs/
- ADVANCED-USAGE.md - Advanced usage scenarios
- CUSTOMIZATION.md - Theme customization options
- HOTKEYS.md - Complete hotkey reference
- INSTALL.md - Detailed installation instructions
- KONSOLE-POWERLINE-VERIFICATION.md - Konsole powerline setup verification
- PERFORMANCE.md - Performance optimization guide
- TROUBLESHOOTING.md - Common issues and solutions

#### /scripts/
- OpenAdminTerminal.ps1 - PowerShell script to open admin terminal
- OpenAdminTerminal.vbs - VBScript wrapper for admin terminal

#### /test/
- test-powerline.sh - Basic powerline symbol testing
- verify-konsole-powerline.sh - Comprehensive Konsole powerline verification

#### /themes/
- rgx.omp.json - Main Oh-My-Posh theme configuration
- /konsole/ - Konsole-specific theme files
  - rgx.colorscheme - Konsole color scheme
  - rgx.profile - Konsole profile configuration

#### /wiki/
- Command-Reference.md - Complete command reference
- Complete-Feature-List.md - Detailed feature list
- Getting-Started.md - Getting started guide
- Home.md - Wiki home page
- Hotkeys-and-Shortcuts.md - Hotkey documentation
- Linux-Like-Features.md - Linux feature equivalents
- README.md - Wiki introduction

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
```bash
npx git+https://github.com/DonnieDice/raspberry-orgasm-terminal.git
```

## Development Commands
- Test theme: `oh-my-posh --config themes/rgx.omp.json print primary`
- Reload profile: `. ~/.bashrc` (Linux) or `. $PROFILE` (Windows)
- Check git status: `git status`
- Run powerline verification: `./test/verify-konsole-powerline.sh`
- Build and deploy: Follow standard git workflow

## Key Files
- index.js - Main entry point for npx installation
- install.ps1 - Windows PowerShell installation script
- install.sh - Linux bash installation script
- themes/rgx.omp.json - Oh-My-Posh theme
- themes/konsole/rgx.colorscheme - Konsole color scheme
- themes/konsole/rgx.profile - Konsole profile

## Testing
Always test changes by:
1. Verifying powerline symbol rendering
2. Checking color accuracy against RGX palette
3. Testing cross-platform compatibility
4. Verifying enhanced tool integration (bat, lsd, rg)
5. Testing copy/paste functionality with formatting

## Repository Optimization Status
✓ 100x Premium organization achieved
✓ Comprehensive documentation coverage
✓ Proper contributor attribution
✓ Clear directory structure
✓ Consistent file naming conventions
✓ Detailed README and documentation
✓ Enhanced testing and verification tools