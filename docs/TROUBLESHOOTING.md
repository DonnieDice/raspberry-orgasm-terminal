# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### "Execution Policy" Error
**Error:** `cannot be loaded because running scripts is disabled on this system`

**Solution:**
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

#### Winget Not Found
**Error:** `The term 'winget' is not recognized`

**Solution:**
1. Install App Installer from Microsoft Store
2. Or download from [GitHub](https://github.com/microsoft/winget-cli/releases)
3. For Windows Server, use Chocolatey instead:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### Scoop Installation Fails
**Error:** `Unable to connect to scoop.sh`

**Solution:**
```powershell
# Manual installation
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/scoopinstaller/install/master/install.ps1' -OutFile 'install.ps1'
.\install.ps1 -RunAsAdmin
```

### Display Issues

#### Fonts Not Displaying Correctly
**Problem:** Seeing boxes or missing characters

**Solutions:**
1. Install Cascadia Code:
```powershell
winget install Microsoft.CascadiaCode
```

2. Change font in terminal settings:
```json
"font": {
    "face": "Cascadia Mono"  // Use Mono if Code doesn't work
}
```

3. Try alternative fonts:
- Consolas
- Courier New
- Lucida Console

#### Colors Not Showing
**Problem:** Terminal appears in default colors

**Solutions:**
1. Ensure using PowerShell 7:
```powershell
$PSVersionTable.PSVersion
# Should show 7.x.x
```

2. Verify color scheme is applied:
- Open Terminal Settings (Ctrl+,)
- Check profile uses "RGX Raspberry" scheme

3. Force color output:
```powershell
$PSStyle.OutputRendering = 'ANSI'
```

#### Transparency Not Working
**Problem:** Acrylic effect not visible

**Solutions:**
1. Check Windows version supports acrylic:
```powershell
[System.Environment]::OSVersion.Version
# Need Windows 10 1903 or later
```

2. Enable in settings:
```json
"useAcrylic": true,
"acrylicOpacity": 0.9
```

3. Disable for performance:
```json
"useAcrylic": false
```

### PowerShell Profile Issues

#### Profile Not Loading
**Problem:** Custom settings not applied on startup

**Solutions:**
1. Check profile path:
```powershell
$PROFILE
Test-Path $PROFILE
```

2. Verify using correct PowerShell:
```powershell
# Should be pwsh.exe, not powershell.exe
$PSVersionTable.Name
```

3. Check for errors:
```powershell
. $PROFILE
# Look for error messages
```

#### Oh My Posh Not Working
**Problem:** Prompt shows as plain text

**Solutions:**
1. Reinstall Oh My Posh:
```powershell
winget uninstall JanDeDobbeleer.OhMyPosh
winget install JanDeDobbeleer.OhMyPosh
```

2. Check theme file exists:
```powershell
Test-Path "$env:USERPROFILE\rgx.omp.json"
```

3. Initialize manually:
```powershell
oh-my-posh init pwsh --config "$env:USERPROFILE\rgx.omp.json" | Invoke-Expression
```

### Tool-Specific Issues

#### Micro Editor Not Found
**Error:** `The term 'micro' is not recognized`

**Solutions:**
1. Reinstall via Scoop:
```powershell
scoop uninstall micro
scoop install micro
```

2. Add to PATH:
```powershell
$env:PATH += ";$env:USERPROFILE\scoop\shims"
```

3. Use direct path:
```powershell
Set-Alias -Name nano -Value "$env:USERPROFILE\scoop\apps\micro\current\micro.exe"
```

#### Bat/Glow/LSD Not Working
**Problem:** Enhanced commands not functioning

**Solutions:**
1. Verify installation:
```powershell
bat --version
glow --version
lsd --version
```

2. Reinstall tools:
```powershell
winget install sharkdp.bat charmbracelet.glow
scoop install lsd
```

3. Check aliases:
```powershell
Get-Alias cat
Get-Alias ls
```

#### Zoxide Not Functioning
**Problem:** `z` command not working

**Solutions:**
1. Initialize zoxide:
```powershell
zoxide init powershell | Invoke-Expression
```

2. Check database:
```powershell
zoxide query -l
```

3. Manually add directories:
```powershell
zoxide add "C:\Your\Directory"
```

### Hotkey Issues

#### Ctrl+Alt+T Not Working
**Problem:** Admin terminal hotkey doesn't respond

**Solutions:**
1. Check shortcut exists:
```powershell
Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk"
```

2. Recreate shortcut:
```powershell
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk")
$Shortcut.TargetPath = "$env:USERPROFILE\OpenAdminTerminal.vbs"
$Shortcut.Hotkey = "CTRL+ALT+T"
$Shortcut.Save()
```

3. Restart Windows to register hotkey

#### Quake Mode (Ctrl+`) Not Working
**Problem:** Terminal doesn't drop down

**Solutions:**
1. Check if another app uses the hotkey
2. Change hotkey in settings:
```json
"keys": "ctrl+shift+`"  // Alternative
```

### Performance Issues

#### Slow Startup
**Problem:** Terminal takes long to open

**Solutions:**
1. Disable unused modules:
```powershell
# Comment out in profile
# Import-Module posh-git
```

2. Reduce history size:
```powershell
Set-PSReadLineOption -MaximumHistoryCount 500
```

3. Disable animations:
```powershell
$PSStyle.Progress.View = 'Minimal'
```

#### High Memory Usage
**Problem:** Terminal consuming too much RAM

**Solutions:**
1. Limit buffer size in settings:
```json
"historySize": 1000  // Reduce from default
```

2. Close unused tabs/panes
3. Disable acrylic effects

### Compatibility Issues

#### WSL Integration
**Problem:** Theme not working in WSL

**Solution:** WSL has limited support. Use native Linux alternatives:
```bash
# In WSL
curl -s https://ohmyposh.dev/install.sh | bash -s
```

#### Remote Desktop
**Problem:** Some features not working over RDP

**Solutions:**
1. Disable acrylic for RDP sessions
2. Use simplified color scheme
3. Reduce graphical effects

### Reset and Recovery

#### Complete Reset
Remove all customizations:
```powershell
# Remove profile
Remove-Item $PROFILE -Force

# Reset terminal settings
Remove-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force

# Remove theme files
Remove-Item "$env:USERPROFILE\rgx.omp.json" -Force
Remove-Item "$env:USERPROFILE\.config\micro" -Recurse -Force
```

#### Safe Mode Profile
Create minimal profile for troubleshooting:
```powershell
# Save as Microsoft.PowerShell_profile.safe.ps1
Set-PSReadLineOption -EditMode Windows
Write-Host "Safe mode profile loaded" -ForegroundColor Yellow
```

Load safe profile:
```powershell
pwsh -NoProfile -Command ". ~\Microsoft.PowerShell_profile.safe.ps1"
```

## Getting Help

### Diagnostic Information
Collect for bug reports:
```powershell
@"
Windows Version: $([System.Environment]::OSVersion.Version)
PowerShell Version: $($PSVersionTable.PSVersion)
Terminal Version: $(wt --version)
Oh My Posh Version: $(oh-my-posh version)
"@ | Out-File "$env:USERPROFILE\Desktop\terminal-diagnostics.txt"
```

### Support Channels
1. [GitHub Issues](https://github.com/donniedice/raspberry-orgasm-terminal/issues)
2. [Discussions](https://github.com/donniedice/raspberry-orgasm-terminal/discussions)
3. Email: support@realmgx.dev

### Debug Mode
Enable verbose output:
```powershell
$VerbosePreference = "Continue"
$DebugPreference = "Continue"
. $PROFILE
```