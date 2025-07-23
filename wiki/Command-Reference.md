# Command Reference

Complete reference for all commands, aliases, and functions available in the Raspberry Orgasm Terminal.

## 📁 File & Directory Commands

### Navigation
| Command | Description | Example |
|---------|-------------|---------|
| `cd` | Change directory (enhanced with zoxide) | `cd ~/Documents` |
| `z` | Smart directory jump | `z proj` |
| `zi` | Interactive directory selection | `zi` |
| `..` | Go up one directory | `..` |
| `...` | Go up two directories | `...` |
| `....` | Go up three directories | `....` |
| `~` | Go to home directory | `~` |
| `home` | Go to home directory | `home` |
| `pwd` | Print working directory | `pwd` |
| `cpwd` | Copy current path to clipboard | `cpwd` |

### Listing Files
| Command | Description | Example |
|---------|-------------|---------|
| `ls` | List files with icons (lsd) | `ls` |
| `ll` | List in long format | `ll` |
| `la` | List all including hidden | `la` |
| `lsd` | Original lsd command | `lsd -la` |
| `tree` | Show directory tree | `tree` |

### File Operations
| Command | Description | Example |
|---------|-------------|---------|
| `touch` | Create empty file | `touch file.txt` |
| `cat` | View file with syntax highlighting | `cat script.ps1` |
| `bat` | Original bat command | `bat --theme=base16` |
| `cp` | Copy files | `cp source.txt dest.txt` |
| `mv` | Move/rename files | `mv old.txt new.txt` |
| `rm` | Remove files | `rm file.txt` |
| `mkdir` | Create directory | `mkdir newfolder` |
| `mkcd` | Create and enter directory | `mkcd newfolder` |
| `backup` | Create timestamped backup | `backup file.txt` |

## ✏️ Text Editing

### Editor Commands
| Command | Description | Example |
|---------|-------------|---------|
| `nano` | Open in micro editor (nano-style) | `nano file.txt` |
| `vim` | Open in micro editor | `vim file.txt` |
| `notepad` | Open in micro editor | `notepad file.txt` |
| `micro` | Original micro command | `micro file.txt` |
| `code` | Open in VS Code | `code .` |
| `edit` | Generic edit command | `edit file.txt` |

### Editor Functions
| Command | Description | Example |
|---------|-------------|---------|
| `profile` | Edit PowerShell profile | `profile` |
| `hosts` | Edit hosts file | `hosts` |
| `settings` | Edit terminal settings | `settings` |

## 🔍 Search Commands

### File Search
| Command | Description | Example |
|---------|-------------|---------|
| `grep` | Search in files (ripgrep) | `grep "TODO"` |
| `rg` | Original ripgrep | `rg -i "pattern"` |
| `find` | Find files | `find *.txt` |
| `fzf` | Fuzzy file finder | `fzf` |
| `search` | Enhanced search function | `search "pattern" . "js"` |

### System Search
| Command | Description | Example |
|---------|-------------|---------|
| `which` | Find command location | `which git` |
| `where` | Windows where command | `where python` |

## 🐙 Git Commands

### Aliases
| Command | Description | Example |
|---------|-------------|---------|
| `gs` | git status | `gs` |
| `ga` | git add . | `ga` |
| `gc` | git commit | `gc "Initial commit"` |
| `gp` | git push | `gp` |
| `gl` | git log graph | `gl` |
| `gai` | git add interactive | `gai` |
| `gb` | git branch with fzf | `gb` |
| `glog` | git log with limit | `glog 10` |
| `gstash` | git stash helper | `gstash "WIP"` |

### Git Functions
| Command | Description | Example |
|---------|-------------|---------|
| `git` | Standard git | `git pull` |
| `delta` | Enhanced diff viewer | Used automatically |

## 🖥️ System Commands

### Information
| Command | Description | Example |
|---------|-------------|---------|
| `neofetch` | System info display | `neofetch` |
| `sysinfo` | Detailed system info | `sysinfo` |
| `Get-TerminalStats` | Terminal resource usage | `Get-TerminalStats` |

### Process Management
| Command | Description | Example |
|---------|-------------|---------|
| `ps` | List processes | `ps` |
| `kill` | Stop process | `kill 1234` |
| `top` | Process monitor | `top` |

## 🎨 Terminal Commands

### Display
| Command | Description | Example |
|---------|-------------|---------|
| `clear` | Clear screen | `clear` |
| `cls` | Clear screen (Windows) | `cls` |
| `cmatrix` | Matrix effect | `cmatrix` |
| `Show-Hotkeys` | Display shortcuts | `Show-Hotkeys` |

### Theme & Config
| Command | Description | Example |
|---------|-------------|---------|
| `Switch-Theme` | Change terminal theme | `Switch-Theme minimal` |
| `reload` | Reload profile | `reload` |
| `refreshenv` | Refresh environment | `refreshenv` |

## 📋 Clipboard Commands

| Command | Description | Example |
|---------|-------------|---------|
| `ccp` | Copy output to clipboard | `ls \| ccp` |
| `pex` | Paste and execute | `pex` |
| `cpwd` | Copy current directory | `cpwd` |
| `clip` | Windows clip command | `echo "text" \| clip` |
| `Set-Clipboard` | PowerShell clipboard | `"text" \| Set-Clipboard` |
| `Get-Clipboard` | Get clipboard content | `Get-Clipboard` |

## 🚀 Productivity Functions

### Project Management
| Command | Description | Example |
|---------|-------------|---------|
| `proj` | Jump to project | `proj work` |
| `Start-DevSession` | Start dev environment | `Start-DevSession myapp` |
| `Backup-Projects` | Backup all projects | `Backup-Projects` |

### Session Management
| Command | Description | Example |
|---------|-------------|---------|
| `Save-Session` | Save terminal state | `Save-Session work` |
| `Restore-Session` | Restore terminal state | `Restore-Session work` |

### Performance
| Command | Description | Example |
|---------|-------------|---------|
| `Measure-CommandTime` | Time command execution | `Measure-CommandTime { ls }` |
| `Profile-Startup` | Analyze startup time | `Profile-Startup` |

## 🛠️ Utility Commands

### Network
| Command | Description | Example |
|---------|-------------|---------|
| `curl` | HTTP requests | `curl https://api.github.com` |
| `wget` | Download files | `wget https://example.com/file` |
| `ping` | Test connectivity | `ping google.com` |

### Archive
| Command | Description | Example |
|---------|-------------|---------|
| `zip` | Create zip archive | `zip archive.zip file.txt` |
| `unzip` | Extract zip archive | `unzip archive.zip` |

## 🎯 Special Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `$PROFILE` | Profile path | `echo $PROFILE` |
| `$HOME` | Home directory | `cd $HOME` |
| `$PWD` | Current directory | `echo $PWD` |
| `$?` | Last command success | `if ($?) { "OK" }` |
| `$LASTEXITCODE` | Last exit code | `echo $LASTEXITCODE` |

## 🔗 Command Chaining

| Syntax | Description | Example |
|--------|-------------|---------|
| `;` | Run sequentially | `cd ~; ls` |
| `&&` | Run if previous succeeded | `mkdir test && cd test` |
| `\|\|` | Run if previous failed | `cd test \|\| mkdir test` |
| `\|` | Pipe output | `ls \| grep ".txt"` |

## 💡 Tips

1. **Tab Completion**: Most commands support tab completion
2. **History**: Use arrow keys or Ctrl+R to search history
3. **Wildcards**: Use `*` and `?` for pattern matching
4. **Help**: Add `-h` or `--help` to most commands for help

---

*This reference covers all commands added by the Raspberry Orgasm Terminal rice. Standard PowerShell commands are also available.*