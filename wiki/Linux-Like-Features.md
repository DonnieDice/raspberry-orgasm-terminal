# Linux-Like Features

This terminal rice brings many Linux conveniences to Windows PowerShell.

## 🚀 Ctrl+Alt+T - Admin Terminal Hotkey

**THE MOST REQUESTED FEATURE!** Just like in Ubuntu/Linux, press `Ctrl+Alt+T` anywhere in Windows to instantly open an elevated (admin) terminal.

### How It Works
- Press `Ctrl+Alt+T` from anywhere in Windows
- A new Windows Terminal opens with admin privileges
- No need to right-click and "Run as Administrator"
- Works globally - in any application, on desktop, anywhere!

### Setup Details
The installer creates:
- `OpenAdminTerminal.ps1` - PowerShell script that launches admin terminal
- `OpenAdminTerminal.vbs` - VBScript wrapper for silent execution
- Start Menu shortcut with `Ctrl+Alt+T` hotkey binding

## 📝 Nano Text Editor

Missing nano from Linux? We've got you covered with `micro` - a modern nano replacement.

### Usage
```powershell
nano file.txt          # Opens file in micro editor
nano ~/.bashrc         # Edit any config file
notepad file.txt       # Also aliased to micro
vim file.txt           # Aliased to micro for muscle memory
```

### Nano-Compatible Keybindings
- `Ctrl+O` - Save file (WriteOut)
- `Ctrl+X` - Exit editor
- `Ctrl+K` - Cut line
- `Ctrl+U` - Paste
- `Ctrl+W` - Search
- `Ctrl+G` - Help

### Why Micro Instead of Nano?
- Native Windows support
- Better syntax highlighting
- Mouse support
- Multiple cursors
- Plugin system
- Same keybindings as nano

## 🔍 Linux Commands That Work

### Directory Navigation
```powershell
cd ~                   # Go to home directory
cd -                   # Go to previous directory (via zoxide)
pwd                    # Print working directory
ls -la                 # List with details (via lsd)
ll                     # Alias for ls
```

### File Operations
```powershell
touch file.txt         # Create empty file
cat file.txt           # View file with syntax highlighting (via bat)
grep "pattern" file    # Search in files (via ripgrep)
find . -name "*.txt"   # Find files (via ripgrep)
```

### Git Shortcuts
```powershell
gs                     # git status
ga                     # git add .
gc "message"           # git commit -m "message"
gp                     # git push
gl                     # git log --oneline --graph
```

### System Commands
```powershell
clear                  # Clear screen (also Ctrl+L)
which command          # Show command location
history                # Command history
sudo command           # Opens UAC prompt for elevation
```

## 🎯 Terminal Behavior

### Linux-Style Features
- **Case-sensitive tab completion** for paths
- **Persistent history** across sessions
- **Ctrl+R** reverse history search
- **Ctrl+L** clear screen
- **Predictive text** based on history
- **Rich copy/paste** preserving colors

### Directory Shortcuts
```powershell
..                     # Go up one directory
...                    # Go up two directories
....                   # Go up three directories
~                      # Home directory
/                      # Root of current drive
```

## 🛠️ Additional Linux Tools

### Installed by Default
- **ripgrep** (`rg`) - Better grep
- **fzf** - Fuzzy finder
- **bat** - Better cat with syntax highlighting
- **lsd** - Better ls with icons
- **delta** - Better git diff
- **glow** - Markdown renderer
- **zoxide** - Smart cd that learns
- **neofetch** - System info display

### Usage Examples
```powershell
# Fuzzy find files
fzf

# Search code with context
rg "TODO" -C 3

# View markdown beautifully
glow README.md

# Smart directory jumping
z proj              # Jumps to ~/source/repos/project
z doc               # Jumps to most used "doc" directory

# System info
neofetch
```

## 🔧 Environment Variables

Just like Linux, you can use:
```powershell
$env:HOME              # Home directory
$env:USER              # Current username
$env:PATH              # System PATH
$env:EDITOR            # Default editor (set to micro)
```

## 📋 Clipboard Integration

Linux-style clipboard commands:
```powershell
# Copy output to clipboard
ls | Set-Clipboard
Get-Process | clip

# Paste from clipboard
Get-Clipboard

# Our custom functions
command | ccp          # Copy command output
pex                    # Paste and execute
cpwd                   # Copy current directory
```

## 🎨 Terminal Multiplexing

While Windows doesn't have tmux, Windows Terminal provides:
- `Ctrl+Shift+-` - Split pane horizontally
- `Ctrl+Shift+\` - Split pane vertically
- `Alt+Arrow` - Navigate between panes
- `Alt+Enter` - Toggle pane zoom
- `Ctrl+Shift+T` - New tab

## 🚦 Exit Codes

Linux-style exit codes work:
```powershell
$?                     # Last command success (True/False)
$LASTEXITCODE          # Numeric exit code
command && echo "OK"   # Run if previous succeeded
command || echo "Failed" # Run if previous failed
```

---

*This rice brings the best of Linux to Windows, making the transition seamless for Linux users while adding Windows-specific enhancements.*