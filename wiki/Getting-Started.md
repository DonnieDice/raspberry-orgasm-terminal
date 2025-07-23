# Getting Started

Welcome to the Raspberry Orgasm Terminal! This guide will help you get up and running quickly.

## 🚀 Installation

### Quick Install (Recommended)
```powershell
iwr -useb https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/install.ps1 | iex
```

This single command installs everything:
- PowerShell 7
- Windows Terminal
- All tools (nano, bat, fzf, etc.)
- Theme and configurations
- Hotkeys including Ctrl+Alt+T

### What Happens During Installation
1. **Prerequisites Check**: Installs PowerShell 7 and Windows Terminal if needed
2. **Tool Installation**: Installs all command-line tools via winget and Scoop
3. **Configuration**: Sets up your terminal theme, profile, and hotkeys
4. **Admin Terminal**: Creates Ctrl+Alt+T global hotkey for admin terminal

## 🎯 First Steps After Installation

### 1. Restart Terminal
Close and reopen Windows Terminal to load all configurations.

### 2. Test Key Features
```powershell
# Test the nano editor
nano test.txt
# Type some text, press Ctrl+O to save, Ctrl+X to exit

# Test admin terminal
# Press Ctrl+Alt+T from anywhere in Windows

# Test smart navigation
z Documents    # If you've been there before
cd ~          # Go home
..            # Go up

# Test git shortcuts
gs            # Shows git status if in a repo

# See all hotkeys
Show-Hotkeys
```

### 3. Explore Commands
```powershell
# Beautiful file listing
ls

# Syntax highlighted file viewing
cat $PROFILE

# System information
neofetch

# Fuzzy file finding
fzf
```

## 🎨 Understanding Your New Terminal

### The Prompt
Your prompt now shows:
```
◆ Username  ~/current/path  git-branch  ▶
```
- **◆** - Session indicator
- **Username** - Your username
- **Path** - Current directory (~ is home)
- **Git branch** - Shows when in a git repository
- **▶** - Input indicator

### Colors Mean Things
- **Red/Pink** - Commands and important items
- **Purple-Grey** - Subtle information
- **Blue** - Special keywords and links
- **Green** - Success/Git clean
- **Yellow** - Warnings/Git dirty

## 🔥 Essential Commands to Learn

### Navigation
- `z [partial-name]` - Jump to any directory you've visited
- `fzf` - Find any file interactively
- `ls` or `ll` - List files with icons

### Editing
- `nano [file]` - Edit any file with familiar keybindings
- `code .` - Open current folder in VS Code

### Git
- `gs` - Quick git status
- `ga` - Stage all changes
- `gc "message"` - Commit with message
- `gp` - Push to remote

### System
- `Show-Hotkeys` - See all keyboard shortcuts
- `reload` - Reload your configuration
- `cpwd` - Copy current path to clipboard

## ⚡ Power User Tips

### 1. Use Tab Completion
Press Tab after typing partial commands or paths:
```powershell
git sta[TAB]     → git status
cd Doc[TAB]      → cd Documents/
```

### 2. Use History Search
Type part of a command and press Up arrow:
```powershell
git [↑]          # Cycles through git commands
```

Or use Ctrl+R for reverse search:
```powershell
[Ctrl+R] install # Finds commands containing "install"
```

### 3. Use the Fuzzy Finder
Find files quickly:
```powershell
# Find and edit a file
nano $(fzf)

# Find and cd to a directory
cd $(fzf -q "src")
```

### 4. Chain Commands
```powershell
# Create and enter directory
mkdir project && cd project

# List files, then search
ls | grep ".txt"
```

## 🛠️ Customization Basics

### Change Your Theme
```powershell
# Switch to minimal theme
Switch-Theme minimal

# Back to raspberry
Switch-Theme raspberry
```

### Edit Your Profile
```powershell
# Open profile in nano
nano $PROFILE

# Or use the function
profile
```

### Adjust Terminal Settings
```powershell
# Open settings
settings

# Or press Ctrl+,
```

## 🆘 Getting Help

### Built-in Help
- `Show-Hotkeys` - Display all keyboard shortcuts
- `[command] --help` - Get help for specific commands
- `Get-Help [command]` - PowerShell help system

### Quick Fixes
If something goes wrong:
```powershell
# Reload your profile
reload

# Reset your PATH
refreshenv

# Check terminal stats
Get-TerminalStats
```

## 📚 Next Steps

1. **Read** [Complete Feature List](Complete-Feature-List.md) to discover all features
2. **Learn** [Hotkeys and Shortcuts](Hotkeys-and-Shortcuts.md) for efficiency
3. **Explore** [Linux-Like Features](Linux-Like-Features.md) if coming from Linux
4. **Master** [Command Reference](Command-Reference.md) for all commands

## 💡 Daily Workflow Example

```powershell
# Start your day
Ctrl+Alt+T               # Open admin terminal if needed
cd ~/source/repos        # Or use: z repos
gs                       # Check git status
code .                   # Open in VS Code

# During development
nano README.md           # Quick edits
ga && gc "Update docs"   # Quick commits
gp                       # Push changes

# End of day
Save-Session work        # Save your state
```

---

*Welcome to your new terminal experience! Remember: `Show-Hotkeys` is your friend!*