# Complete Hotkey Reference

## Terminal Navigation

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+`` | Quake Mode | Global terminal summon/hide |
| `F11` | Focus Mode | Hide tabs and title bar |
| `Ctrl+Shift+A` | Always on Top | Keep terminal above other windows |
| `Ctrl+Shift+T` | New Tab Menu | Open new tab dropdown |
| `Ctrl+Tab` | Next Tab | Switch to next tab |
| `Ctrl+Shift+Tab` | Previous Tab | Switch to previous tab |
| `Alt+[1-9]` | Switch Tab | Jump to specific tab number |

## Pane Management

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+Shift+-` | Split Horizontal | Split current pane horizontally |
| `Ctrl+Shift+\` | Split Vertical | Split current pane vertically |
| `Alt+Up` | Focus Up | Move focus to pane above |
| `Alt+Down` | Focus Down | Move focus to pane below |
| `Alt+Left` | Focus Left | Move focus to left pane |
| `Alt+Right` | Focus Right | Move focus to right pane |
| `Alt+Enter` | Zoom Pane | Toggle pane zoom |
| `Ctrl+Shift+W` | Close Pane | Close current pane |

## Text Operations

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+F` | Find | Search in terminal output |
| `Ctrl+L` | Clear | Clear terminal screen |
| `Ctrl+Shift+C` | Copy | Copy with formatting |
| `Ctrl+Shift+V` | Paste | Paste text |
| `Ctrl+A` | Select All | Select all terminal output |
| `Shift+Click` | Select Text | Select text between clicks |

## Font and Display

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+=` | Increase Font | Make text larger |
| `Ctrl+-` | Decrease Font | Make text smaller |
| `Ctrl+0` | Reset Font | Reset to default size |
| `Alt+Shift+D` | Toggle Pane Split | Switch split orientation |

## Advanced Features

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+Alt+T` | Admin Terminal | Open elevated terminal |
| `Ctrl+Shift+P` | Command Palette | Open command palette |
| `Ctrl+,` | Settings | Open terminal settings |
| `Ctrl+Shift+F` | Search All Tabs | Search across all tabs |

## PowerShell Specific

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Tab` | Autocomplete | Menu-based completion |
| `Ctrl+Space` | Show Suggestions | Force show suggestions |
| `Up Arrow` | History Search Back | Search backward in history |
| `Down Arrow` | History Search Forward | Search forward in history |
| `Ctrl+R` | Reverse Search | Search command history |
| `Ctrl+D` | Delete Character | Delete character forward |
| `Ctrl+W` | Delete Word | Delete word backward |
| `Ctrl+K` | Delete to End | Delete to end of line |
| `Ctrl+U` | Delete to Start | Delete to start of line |
| `Ctrl+LeftArrow` | Word Left | Move cursor word left |
| `Ctrl+RightArrow` | Word Right | Move cursor word right |
| `Home` | Line Start | Move to start of line |
| `End` | Line End | Move to end of line |

## Micro Editor (Nano-style)

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+O` | Save | Save current file |
| `Ctrl+X` | Exit | Exit editor |
| `Ctrl+G` | Help | Toggle help display |
| `Ctrl+W` | Find | Search in file |
| `Ctrl+Q` | Find Next | Find next occurrence |
| `Ctrl+K` | Cut Line | Cut current line |
| `Ctrl+U` | Paste | Paste from clipboard |
| `Ctrl+C` | Show Position | Show cursor position |
| `F1` | Help | Show help |
| `F2` | Save | Save file |
| `F3` | Find | Search in file |
| `F4` | Quit | Exit editor |

## Git Shortcuts (Aliases)

| Command | Action | Description |
|---------|--------|-------------|
| `gs` | Git Status | Show repository status |
| `ga` | Git Add All | Stage all changes |
| `gc "msg"` | Git Commit | Commit with message |
| `gp` | Git Push | Push to remote |
| `gl` | Git Log | Show commit graph |

## Navigation Shortcuts

| Command | Action | Description |
|---------|--------|-------------|
| `z folder` | Smart CD | Jump to frecent directory |
| `..` | Parent Directory | Go up one level |
| `...` | Grandparent | Go up two levels |
| `home` | Home Directory | Go to user home |
| `reload` | Reload Profile | Reload PowerShell config |

## Quick Commands

| Command | Action | Description |
|---------|--------|-------------|
| `touch file` | Create File | Create empty file |
| `mkcd folder` | Make & Enter | Create and enter directory |
| `ls` | List Enhanced | List with icons (lsd) |
| `cat file` | View Highlighted | View with syntax highlighting |
| `nano file` | Edit File | Open in micro editor |

## FZF (Fuzzy Finder)

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+T` | File Finder | Fuzzy find files |
| `Ctrl+R` | History Search | Fuzzy search history |
| `Alt+C` | CD to Directory | Fuzzy change directory |
| `Tab` | Select/Deselect | Toggle selection in list |
| `Ctrl+A` | Select All | Select all items |
| `Ctrl+D` | Deselect All | Deselect all items |

## Terminal Multiplexer Style

| Hotkey | Action | Description |
|--------|--------|-------------|
| `Ctrl+Shift+N` | New Window | Open new terminal window |
| `Alt+F4` | Close Window | Close terminal window |
| `Win+Up` | Maximize | Maximize window |
| `Win+Down` | Restore/Minimize | Restore or minimize |
| `Win+Left/Right` | Snap | Snap to screen edge |

## Custom Functions

To see all available hotkeys in terminal:
```powershell
Show-Hotkeys
```

## Customizing Hotkeys

To modify hotkeys, edit the terminal settings:
```powershell
# Open settings file
notepad "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
```

Add or modify in the `keybindings` section:
```json
{
    "command": "your-command",
    "keys": "ctrl+shift+y"
}
```

## Tips

1. **Muscle Memory**: Focus on learning 5-10 most useful hotkeys first
2. **Efficiency**: Combine with PowerShell aliases for maximum speed
3. **Customization**: Adapt hotkeys to match your workflow
4. **Practice**: Use `Show-Hotkeys` as a quick reference

## Conflicts

If hotkeys conflict with other applications:

1. Check Windows Terminal settings for conflicts
2. Modify conflicting hotkeys in settings.json
3. Disable global hotkeys if needed
4. Use alternative key combinations

## Platform-Specific Notes

- **Windows 11**: All hotkeys fully supported
- **Windows 10**: Some global hotkeys may require restart
- **Remote Desktop**: Ctrl+Alt combinations might be intercepted
- **WSL**: Limited support for some Windows-specific features