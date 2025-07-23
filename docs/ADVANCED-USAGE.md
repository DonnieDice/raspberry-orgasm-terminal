# Advanced Usage Guide

## Power User Features

### 1. Custom Functions

Add these powerful functions to your profile for enhanced productivity:

```powershell
# Quick project navigator
function proj {
    param($name)
    $projects = @{
        "work" = "C:\Users\$env:USERNAME\Documents\Work"
        "personal" = "C:\Users\$env:USERNAME\Documents\Personal"
        "repos" = "C:\Users\$env:USERNAME\source\repos"
    }
    
    if ($projects.ContainsKey($name)) {
        Set-Location $projects[$name]
    } else {
        Write-Host "Unknown project. Available: $($projects.Keys -join ', ')" -ForegroundColor Yellow
    }
}

# Enhanced file search
function search {
    param(
        [string]$pattern,
        [string]$path = ".",
        [string]$type = "*"
    )
    
    rg -i $pattern $path -g "*.$type" --color=always | bat --style=numbers
}

# Quick backup function
function backup {
    param($path)
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupName = "$path.backup_$timestamp"
    Copy-Item $path $backupName -Recurse
    Write-Host "Backed up to: $backupName" -ForegroundColor Green
}
```

### 2. Git Workflow Enhancements

```powershell
# Interactive git add
function gai {
    git add -i
}

# Git log with graph
function glog {
    param([int]$n = 20)
    git log --oneline --graph --decorate --all -n $n
}

# Quick branch switching with fuzzy finder
function gb {
    $branch = git branch -a | fzf | ForEach-Object { $_.Trim() }
    if ($branch) {
        git checkout $branch.Replace("remotes/origin/", "")
    }
}

# Git stash with message
function gstash {
    param($message)
    if ($message) {
        git stash push -m $message
    } else {
        git stash list
    }
}
```

### 3. Terminal Multiplexing

Use Windows Terminal's advanced features:

```powershell
# Open split panes programmatically
function Split-Terminal {
    param(
        [ValidateSet("horizontal", "vertical")]
        [string]$Direction = "vertical",
        [string]$Command = "pwsh"
    )
    
    wt -w 0 split-pane -$Direction[0] $Command
}

# Create development layout
function Dev-Layout {
    # Main editor pane
    wt -w 0 new-tab pwsh -NoExit -Command "micro"
    Start-Sleep -Milliseconds 500
    
    # Git status pane
    wt -w 0 split-pane -H -s 0.3 pwsh -NoExit -Command "git status"
    Start-Sleep -Milliseconds 500
    
    # Build output pane
    wt -w 0 split-pane -V -s 0.5 pwsh
}
```

### 4. Advanced Aliases

```powershell
# Directory navigation
Set-Alias -Name ".." -Value "cd .." -Force
Set-Alias -Name "..." -Value "cd ..\.." -Force
Set-Alias -Name "...." -Value "cd ..\..\.." -Force

# Quick edits
function hosts { micro "C:\Windows\System32\drivers\etc\hosts" }
function profile { micro $PROFILE }
function settings { code "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" }

# System info
function sysinfo {
    Write-Host "System Information" -ForegroundColor Cyan
    Write-Host "=================" -ForegroundColor Cyan
    Get-ComputerInfo | Select-Object `
        CsName,
        WindowsVersion,
        WindowsBuildLabEx,
        OsArchitecture,
        CsTotalPhysicalMemory,
        CsNumberOfProcessors,
        CsNumberOfLogicalProcessors |
        Format-List
}
```

### 5. Custom Prompt Segments

Create dynamic prompt segments:

```json
{
  "type": "command",
  "style": "diamond",
  "foreground": "#ffffff",
  "background": "#e30b5c",
  "leading_diamond": "\uE0B6",
  "properties": {
    "command": "Get-Date -Format 'HH:mm'",
    "shell": "pwsh"
  },
  "template": " \uF017 {{ .Output }} "
}
```

### 6. Keyboard Macros

```powershell
# Register custom key handlers
Set-PSReadLineKeyHandler -Chord "Ctrl+g" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("git status")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+g" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("git add . && git commit -m '' && git push")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition(26)
}
```

### 7. Clipboard Integration

```powershell
# Copy command output to clipboard
function ccp {
    param([Parameter(ValueFromPipeline)]$input)
    $input | Set-Clipboard
    Write-Host "Copied to clipboard!" -ForegroundColor Green
}

# Paste and execute from clipboard
function pex {
    $command = Get-Clipboard
    Write-Host "Executing: $command" -ForegroundColor Yellow
    Invoke-Expression $command
}

# Copy current directory to clipboard
function cpwd {
    $PWD.Path | Set-Clipboard
    Write-Host "Path copied: $($PWD.Path)" -ForegroundColor Green
}
```

### 8. Theme Switching

```powershell
# Switch between themes
function Switch-Theme {
    param(
        [ValidateSet("raspberry", "minimal", "powerline")]
        [string]$Theme = "raspberry"
    )
    
    $themes = @{
        "raspberry" = "$env:USERPROFILE\rgx.omp.json"
        "minimal" = "$env:USERPROFILE\minimal.omp.json"
        "powerline" = "$env:USERPROFILE\powerline.omp.json"
    }
    
    oh-my-posh init pwsh --config $themes[$Theme] | Invoke-Expression
    Write-Host "Switched to $Theme theme" -ForegroundColor Green
}
```

### 9. Session Management

```powershell
# Save current session
function Save-Session {
    param($name = "default")
    $sessionPath = "$env:USERPROFILE\.terminal-sessions\$name.txt"
    
    # Create directory if needed
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.terminal-sessions" -Force | Out-Null
    
    # Save current directory and history
    @{
        Path = $PWD.Path
        History = Get-History | Select-Object -ExpandProperty CommandLine
        Date = Get-Date
    } | ConvertTo-Json | Out-File $sessionPath
    
    Write-Host "Session saved: $name" -ForegroundColor Green
}

# Restore session
function Restore-Session {
    param($name = "default")
    $sessionPath = "$env:USERPROFILE\.terminal-sessions\$name.txt"
    
    if (Test-Path $sessionPath) {
        $session = Get-Content $sessionPath | ConvertFrom-Json
        Set-Location $session.Path
        Write-Host "Session restored: $name (saved $($session.Date))" -ForegroundColor Green
    }
}
```

### 10. Performance Profiling

```powershell
# Profile command execution time
function Measure-CommandTime {
    param(
        [scriptblock]$Command
    )
    
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $result = & $Command
    $sw.Stop()
    
    Write-Host "Execution time: $($sw.ElapsedMilliseconds)ms" -ForegroundColor Cyan
    return $result
}

# Profile startup
function Profile-Startup {
    $profilePath = $PROFILE
    $lines = Get-Content $profilePath
    
    foreach ($line in $lines) {
        if ($line.Trim() -and -not $line.StartsWith("#")) {
            $time = (Measure-Command { Invoke-Expression $line }).TotalMilliseconds
            if ($time -gt 50) {
                Write-Host "$([math]::Round($time, 2))ms: $line" -ForegroundColor Yellow
            }
        }
    }
}
```

## Integration with Other Tools

### VS Code Integration

```powershell
# Open in VS Code with specific settings
function code {
    param($path = ".")
    & "C:\Program Files\Microsoft VS Code\Code.exe" $path --new-window
}

# Quick code search
function Search-Code {
    param($pattern)
    code --goto "$(fzf --preview 'bat --color=always {}')"
}
```

### Docker Integration

```powershell
# Docker shortcuts
function dps { docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" }
function dex { param($container, $command = "bash") docker exec -it $container $command }
function dlogs { param($container) docker logs -f $container }
```

### Cloud CLI Integration

```powershell
# Azure CLI with autocomplete
Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    az 2>&1 | Out-Null
    Get-Content $completion_file -Raw
    Remove-Item $completion_file -Force
}
```

## Custom Workflows

### Development Workflow

```powershell
function Start-DevSession {
    param($project)
    
    # Navigate to project
    proj $project
    
    # Start services
    docker-compose up -d
    
    # Open editor
    code .
    
    # Show status
    Write-Host "Development session started for $project" -ForegroundColor Green
    git status
}
```

### Backup Workflow

```powershell
function Backup-Projects {
    $projects = Get-ChildItem "C:\Users\$env:USERNAME\source\repos" -Directory
    
    foreach ($project in $projects) {
        Write-Host "Backing up $($project.Name)..." -ForegroundColor Cyan
        
        # Git backup
        Push-Location $project.FullName
        if (Test-Path .git) {
            git add .
            git commit -m "Auto-backup $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
            git push
        }
        Pop-Location
    }
}
```

## Advanced Terminal Settings

### Custom Actions

Add to your terminal settings.json:

```json
"actions": [
    {
        "command": {
            "action": "sendInput",
            "input": "Clear-Host\r"
        },
        "keys": "ctrl+k",
        "name": "Clear Terminal"
    },
    {
        "command": {
            "action": "multipleActions",
            "actions": [
                { "action": "splitPane", "split": "vertical" },
                { "action": "sendInput", "input": "htop\r" }
            ]
        },
        "keys": "ctrl+shift+h",
        "name": "Open System Monitor"
    }
]
```

## Tips & Tricks

1. **Use Tab Completion**: Most custom functions support tab completion
2. **Chain Commands**: Use `&&` and `||` for command chaining
3. **Background Jobs**: Use `Start-Job` for long-running tasks
4. **Persistent History**: Your command history persists across sessions
5. **Quick Search**: Use `Ctrl+R` for reverse history search

## Conclusion

These advanced features transform your terminal into a powerful development environment. Customize and extend based on your workflow needs!