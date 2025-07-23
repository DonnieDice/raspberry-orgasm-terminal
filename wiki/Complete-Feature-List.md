# Complete Feature List

This rice includes EVERYTHING you need for a modern terminal experience.

## 🎨 Visual Features

### Terminal Appearance
- **Raspberry/Burgundy color scheme** with purple-grey accents
- **Semi-transparent background** (90% opacity)
- **Custom ASCII art** on startup
- **Single-line powerline prompt** with git integration
- **Syntax highlighting** in terminal output
- **Icon support** for files and directories
- **Rich text copy/paste** - preserves colors and formatting

### Color Palette
- Background: `#1f0d24` (Deep purple-black)
- Foreground: `#ffdbe9` (Light pink)
- Primary: `#e30b5c` (RGX Red)
- Secondary: `#db2777` (Cranberry)
- Accent: `#9d7ba8` (Purple-grey)

## ⌨️ Hotkeys & Shortcuts

### Global Hotkeys
- **Ctrl+Alt+T** - Open admin terminal from anywhere (Linux-style!)
- **Ctrl+`** - Quake dropdown terminal
- **Win+`** - Another dropdown terminal option

### Terminal Navigation
- **F11** - Toggle focus mode (hide UI)
- **Ctrl+Shift+T** - New tab
- **Ctrl+Shift+W** - Close tab
- **Ctrl+Tab** - Next tab
- **Ctrl+Shift+Tab** - Previous tab
- **Ctrl+Shift+-** - Split horizontal
- **Ctrl+Shift+\** - Split vertical
- **Alt+Arrow** - Move between panes
- **Alt+Enter** - Toggle pane zoom
- **Ctrl+Shift+A** - Toggle always on top

### Text Operations
- **Ctrl+Shift+C** - Copy with formatting
- **Ctrl+Shift+V** - Paste
- **Ctrl+F** - Find in terminal
- **Ctrl+L** - Clear screen
- **Ctrl+Plus/Minus** - Zoom in/out

### Command Line Editing
- **Tab** - Autocomplete with menu
- **Ctrl+R** - Reverse history search
- **Ctrl+D** - Delete character
- **Ctrl+W** - Delete word
- **Ctrl+A** - Beginning of line
- **Ctrl+E** - End of line
- **Ctrl+LeftArrow** - Previous word
- **Ctrl+RightArrow** - Next word
- **Up/Down** - History search based on current input

## 🛠️ Installed Tools

### Core Utilities
1. **PowerShell 7** - Modern PowerShell
2. **Windows Terminal** - Modern terminal emulator
3. **Oh My Posh** - Prompt theming engine
4. **Scoop** - Command-line installer

### Text & Code Tools
1. **micro** - Modern nano-like editor
   - Invoked with: `nano`, `vim`, `notepad`, `micro`
   - Nano keybindings (Ctrl+O save, Ctrl+X exit)
   
2. **bat** - Better `cat` with syntax highlighting
   - Syntax highlighting for 150+ languages
   - Git integration showing changes
   - Line numbers and paging

3. **ripgrep** (`rg`) - Ultra-fast grep
   - Search code repositories
   - Respects .gitignore
   - Unicode support

### File & Directory Tools
1. **lsd** - Modern `ls` replacement
   - File icons
   - Git status integration
   - Tree view support
   - Human-readable sizes

2. **zoxide** - Smarter `cd`
   - Learns your habits
   - Jump to directories by partial name
   - Works with `z` command

3. **fzf** - Fuzzy finder
   - Interactive file search
   - Command history search
   - Process killer
   - Git branch switcher

### Development Tools
1. **delta** - Better git diff
   - Syntax highlighting
   - Side-by-side view
   - Line numbers
   - Git integration

2. **glow** - Markdown renderer
   - Render markdown in terminal
   - Syntax highlighting
   - Local and remote files

### System Tools
1. **neofetch** - System info display
   - Shows OS, hardware, uptime
   - Custom ASCII art support

2. **cmatrix** - Matrix rain effect
   - Just for fun!

## 📝 Aliases & Functions

### Directory Navigation
```powershell
ls          → lsd with colors and icons
ll          → ls in list format
la          → ls including hidden files
..          → cd ..
...         → cd ../..
....        → cd ../../..
~           → cd $HOME
home        → cd $HOME
z [dir]     → smart cd to frecent directory
```

### Git Aliases
```powershell
gs          → git status
ga          → git add .
gc "msg"    → git commit -m "msg"
gp          → git push
gl          → git log --oneline --graph
gai         → git add interactive
gb          → git branch switcher with fzf
glog [n]    → git log with graph (last n commits)
gstash      → git stash management
```

### Editor Aliases
```powershell
nano        → micro editor
vim         → micro editor
notepad     → micro editor
edit        → micro editor
```

### File Operations
```powershell
touch       → create empty file
cat         → view file with syntax highlighting (bat)
grep        → search with ripgrep
find        → find files with ripgrep
which       → show command location
```

### Utility Functions
```powershell
reload      → reload PowerShell profile
mkcd        → make directory and cd into it
backup      → create timestamped backup
search      → enhanced file search
sysinfo     → detailed system information
proj [name] → quick project navigation
```

### Terminal Functions
```powershell
Show-Hotkeys     → display all keyboard shortcuts
Switch-Theme     → switch between terminal themes
Save-Session     → save current session state
Restore-Session  → restore saved session
Get-TerminalStats → show terminal resource usage
```

### Clipboard Functions
```powershell
ccp         → copy command output to clipboard
pex         → paste and execute from clipboard
cpwd        → copy current directory to clipboard
```

## 🎯 Smart Features

### Predictive Text
- History-based suggestions
- Plugin-based predictions
- ListView display of suggestions
- Smart command completion

### Git Integration
- Current branch in prompt
- Dirty state indicators
- Ahead/behind counters
- Stash count

### Path Intelligence
- Frecency-based directory jumping
- Bookmarked locations
- Recent directory history
- Project-aware navigation

### Rich Copy/Paste
- Preserves ANSI colors
- Maintains formatting
- Works with Office apps
- HTML/RTF support

## 🔧 Configuration Files

### Created/Modified
- `$PROFILE` - PowerShell profile with all settings
- `~/rgx.omp.json` - Oh My Posh theme
- `~/.config/micro/` - Micro editor settings
- `~/OpenAdminTerminal.ps1` - Admin terminal launcher
- `%LOCALAPPDATA%/.../settings.json` - Windows Terminal config

### Environment Variables Set
- `$env:EDITOR` = micro
- `$env:FZF_DEFAULT_OPTS` - FZF theming
- Various PATH additions for tools

## 🚀 Performance Features

- Lazy loading of heavy modules
- Optimized prompt rendering
- Efficient git status caching
- Minimal startup time (<2s)
- Low memory footprint (<100MB)

## 🎨 Customization Options

- Multiple theme variants available
- Customizable hotkeys
- Adjustable transparency
- Font selection
- Color scheme modifications
- Prompt segment customization

---

*This is the COMPLETE rice - everything you need for a powerful, beautiful terminal experience on Windows!*