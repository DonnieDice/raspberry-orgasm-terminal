# Hotkeys and Shortcuts Reference

Complete keyboard shortcut reference for the Raspberry Orgasm Terminal.

## 🌍 Global System Hotkeys

These work from ANYWHERE in Windows:

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+Alt+T** | Open Admin Terminal | Just like Linux! Opens elevated terminal |
| **Ctrl+`** | Quake Dropdown Terminal | Toggle terminal visibility |
| **Win+`** | Alternative Dropdown | Another way to summon terminal |

## 🖥️ Terminal Window Management

| Hotkey | Action | Notes |
|--------|--------|-------|
| **F11** | Toggle Focus Mode | Hide tabs and title bar |
| **Ctrl+Shift+A** | Always On Top | Keep terminal above other windows |
| **Alt+Enter** | Toggle Fullscreen | Maximize current pane |
| **Ctrl+=** | Zoom In | Increase font size |
| **Ctrl+-** | Zoom Out | Decrease font size |
| **Ctrl+0** | Reset Zoom | Default font size |

## 📑 Tab Management

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+Shift+T** | New Tab | Open new PowerShell tab |
| **Ctrl+Shift+N** | New Window | Open new terminal window |
| **Ctrl+Shift+W** | Close Tab | Close current tab |
| **Ctrl+Tab** | Next Tab | Cycle forward through tabs |
| **Ctrl+Shift+Tab** | Previous Tab | Cycle backward through tabs |
| **Ctrl+Shift+[1-9]** | Switch to Tab N | Jump to specific tab |
| **Ctrl+Alt+[1-9]** | Move Tab to Position | Reorder tabs |

## 🔲 Pane Management

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+Shift+-** | Split Horizontal | Split pane horizontally |
| **Ctrl+Shift+\\** | Split Vertical | Split pane vertically |
| **Alt+Left** | Focus Left Pane | Move to pane on left |
| **Alt+Right** | Focus Right Pane | Move to pane on right |
| **Alt+Up** | Focus Up Pane | Move to pane above |
| **Alt+Down** | Focus Down Pane | Move to pane below |
| **Alt+Enter** | Toggle Pane Zoom | Maximize/restore current pane |
| **Ctrl+Shift+Q** | Close Pane | Close current pane |

## 📋 Copy & Paste

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+Shift+C** | Copy | Copy with formatting preserved |
| **Ctrl+Shift+V** | Paste | Paste text |
| **Ctrl+C** | Copy (if selected) | Standard copy when text selected |
| **Ctrl+V** | Paste (in some modes) | May work depending on settings |
| **Shift+Insert** | Paste | Alternative paste |
| **Mouse Select** | Auto-copy | Automatically copies selection |

## 🔍 Search & Navigation

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+F** | Find | Search in terminal output |
| **F3** | Find Next | Next search result |
| **Shift+F3** | Find Previous | Previous search result |
| **Ctrl+L** | Clear Screen | Clear terminal display |
| **Ctrl+Home** | Scroll to Top | Go to beginning of buffer |
| **Ctrl+End** | Scroll to Bottom | Go to end of buffer |
| **Ctrl+Up** | Scroll Up | Scroll up one line |
| **Ctrl+Down** | Scroll Down | Scroll down one line |

## ✏️ Command Line Editing

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Tab** | Autocomplete | Menu-based completion |
| **Ctrl+Space** | Show Suggestions | Force suggestion menu |
| **Ctrl+R** | Reverse Search | Search command history |
| **Up Arrow** | Previous Command | History filtered by current input |
| **Down Arrow** | Next Command | History filtered by current input |
| **Ctrl+A** | Beginning of Line | Jump to start |
| **Ctrl+E** | End of Line | Jump to end |
| **Ctrl+LeftArrow** | Previous Word | Move word by word |
| **Ctrl+RightArrow** | Next Word | Move word by word |
| **Ctrl+D** | Delete Character | Delete char under cursor |
| **Ctrl+H** | Backspace | Delete previous character |
| **Ctrl+W** | Delete Word | Delete word before cursor |
| **Ctrl+K** | Delete to End | Delete from cursor to end |
| **Ctrl+U** | Delete to Start | Delete from cursor to beginning |
| **Alt+D** | Delete Next Word | Delete word after cursor |

## 📝 Nano/Micro Editor Shortcuts

When using `nano` (which opens micro):

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+O** | Save File | WriteOut (nano compatible) |
| **Ctrl+X** | Exit Editor | Exit, prompts to save |
| **Ctrl+S** | Save | Alternative save |
| **Ctrl+Q** | Quit | Alternative quit |
| **Ctrl+K** | Cut Line | Cut entire line |
| **Ctrl+U** | Paste | Paste cut text |
| **Ctrl+W** | Search | Find in file |
| **Ctrl+\\** | Replace | Find and replace |
| **Ctrl+G** | Help | Show help |
| **F1** | Help | Alternative help |
| **F2** | Save | Quick save |
| **F3** | Find | Quick find |
| **F4** | Quit | Quick quit |
| **Ctrl+Z** | Undo | Undo last action |
| **Ctrl+Y** | Redo | Redo undone action |

## 🎮 Custom PowerShell Shortcuts

These are custom key handlers added by the rice:

| Hotkey | Action | Notes |
|--------|--------|-------|
| **Ctrl+G** | Quick Git Status | Runs `git status` |
| **Ctrl+Shift+G** | Git Commit Flow | Adds, commits, and positions cursor |
| **Alt+S** | Quick Save | Save current command to file |
| **Alt+L** | List Directory | Quick `ls` |

## 🖱️ Mouse Shortcuts

| Action | Result |
|--------|--------|
| **Right Click** | Paste (if enabled) |
| **Select Text** | Auto-copy (if enabled) |
| **Ctrl+Click URL** | Open in browser |
| **Wheel Up/Down** | Scroll through output |
| **Shift+Wheel** | Scroll faster |

## 💡 Special Key Combinations

### Quick Actions
- **Double-tap Ctrl** - Show command palette (if configured)
- **Ctrl+Shift+P** - Command palette
- **Ctrl+,** - Open settings
- **Ctrl+Shift+,** - Open default settings

### Session Management
- **Ctrl+Shift+D** - Duplicate current tab/pane
- **Alt+Shift+D** - Duplicate pane in new tab
- **Ctrl+Shift+Q** - Close all tabs (exit terminal)

## 🔧 Customizing Hotkeys

To add or modify hotkeys, edit the Windows Terminal settings:

```json
"keybindings": [
    {
        "command": "your-command",
        "keys": "ctrl+shift+x"
    }
]
```

Or add PowerShell key handlers in your profile:

```powershell
Set-PSReadLineKeyHandler -Chord "Ctrl+J" -ScriptBlock {
    # Your custom action
}
```

## 📱 Touch/Trackpad Gestures

If using a touchscreen or precision trackpad:

- **Pinch** - Zoom in/out
- **Two-finger scroll** - Scroll through output
- **Three-finger swipe** - Switch between tabs

---

*Pro tip: Run `Show-Hotkeys` in the terminal for a quick reference!*