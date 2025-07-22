# Raspberry Orgasm PowerShell Terminal Theme Installer
# By RGX Mods / RealmGX

param(
    [switch]$SkipPrerequisites,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "   " -NoNewline
Write-Host "╦═╗" -ForegroundColor Magenta -NoNewline
Write-Host "┌─┐┌─┐┌─┐┌┐ ┌─┐┬─┐┬─┐┬ ┬  " -ForegroundColor DarkRed -NoNewline
Write-Host "╔═╗" -ForegroundColor Magenta -NoNewline
Write-Host "┬─┐┌─┐┌─┐┌─┐┌┬┐" -ForegroundColor DarkRed
Write-Host "   " -NoNewline
Write-Host "╠╦╝" -ForegroundColor Magenta -NoNewline
Write-Host "├─┤└─┐├─┘├┴┐├┤ ├┬┘├┬┘└┬┘  " -ForegroundColor DarkRed -NoNewline
Write-Host "║ ║" -ForegroundColor Magenta -NoNewline
Write-Host "├┬┘│ ┬├─┤└─┐│││" -ForegroundColor DarkRed
Write-Host "   " -NoNewline
Write-Host "╩╚═" -ForegroundColor Magenta -NoNewline
Write-Host "┴ ┴└─┘┴  └─┘└─┘┴└─┴└─ ┴   " -ForegroundColor DarkRed -NoNewline
Write-Host "╚═╝" -ForegroundColor Magenta -NoNewline
Write-Host "┴└─└─┘┴ ┴└─┘┴ ┴" -ForegroundColor DarkRed
Write-Host "          PowerShell Terminal Theme Installer" -ForegroundColor Gray
Write-Host ""

function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-Prerequisites {
    Write-Host "Installing prerequisites..." -ForegroundColor Cyan
    
    # Install Windows Terminal if not present
    try {
        $wt = Get-Command wt.exe -ErrorAction SilentlyContinue
        if (-not $wt) {
            Write-Host "Installing Windows Terminal..." -ForegroundColor Yellow
            winget install Microsoft.WindowsTerminal -h --accept-source-agreements --accept-package-agreements
        }
    } catch {
        Write-Host "Failed to install Windows Terminal. Please install manually." -ForegroundColor Red
    }
    
    # Install PowerShell 7
    try {
        $pwsh7 = Get-Command pwsh.exe -ErrorAction SilentlyContinue
        if (-not $pwsh7) {
            Write-Host "Installing PowerShell 7..." -ForegroundColor Yellow
            winget install Microsoft.PowerShell -h --accept-source-agreements --accept-package-agreements
        }
    } catch {
        Write-Host "Failed to install PowerShell 7. Please install manually." -ForegroundColor Red
    }
    
    # Install core tools via winget
    $wingetTools = @(
        @{id = "JanDeDobbeleer.OhMyPosh"; name = "Oh My Posh"},
        @{id = "sharkdp.bat"; name = "bat"},
        @{id = "charmbracelet.glow"; name = "glow"},
        @{id = "BurntSushi.ripgrep"; name = "ripgrep"},
        @{id = "junegunn.fzf"; name = "fzf"},
        @{id = "ajeetdsouza.zoxide"; name = "zoxide"}
    )
    
    foreach ($tool in $wingetTools) {
        try {
            Write-Host "Installing $($tool.name)..." -ForegroundColor Yellow
            winget install $tool.id -h --accept-source-agreements --accept-package-agreements
        } catch {
            Write-Host "Failed to install $($tool.name)" -ForegroundColor Red
        }
    }
    
    # Install Scoop
    try {
        $scoop = Get-Command scoop -ErrorAction SilentlyContinue
        if (-not $scoop) {
            Write-Host "Installing Scoop package manager..." -ForegroundColor Yellow
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            iwr -useb get.scoop.sh | iex
        }
    } catch {
        Write-Host "Failed to install Scoop" -ForegroundColor Red
    }
    
    # Install Scoop tools
    $scoopTools = @("micro", "lsd", "neofetch", "git", "delta")
    foreach ($tool in $scoopTools) {
        try {
            Write-Host "Installing $tool via Scoop..." -ForegroundColor Yellow
            scoop install $tool
        } catch {
            Write-Host "Failed to install $tool" -ForegroundColor Red
        }
    }
}

function Install-TerminalConfig {
    Write-Host "Configuring Windows Terminal..." -ForegroundColor Cyan
    
    $terminalPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    
    if (-not (Test-Path $terminalPath)) {
        New-Item -ItemType Directory -Path $terminalPath -Force | Out-Null
    }
    
    # Backup existing settings if they exist
    $settingsPath = "$terminalPath\settings.json"
    if (Test-Path $settingsPath) {
        $backupPath = "$terminalPath\settings.backup.$(Get-Date -Format 'yyyyMMddHHmmss').json"
        Copy-Item $settingsPath $backupPath
        Write-Host "Backed up existing settings to: $backupPath" -ForegroundColor Green
    }
    
    # Copy terminal settings
    Copy-Item "$PSScriptRoot\config\terminal-settings.json" $settingsPath -Force
    Write-Host "Terminal settings applied" -ForegroundColor Green
}

function Install-PowerShellProfile {
    Write-Host "Configuring PowerShell profile..." -ForegroundColor Cyan
    
    # Create profile directory if it doesn't exist
    $profileDir = Split-Path $PROFILE -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    
    # Backup existing profile
    if (Test-Path $PROFILE) {
        $backupPath = "$profileDir\Microsoft.PowerShell_profile.backup.$(Get-Date -Format 'yyyyMMddHHmmss').ps1"
        Copy-Item $PROFILE $backupPath
        Write-Host "Backed up existing profile to: $backupPath" -ForegroundColor Green
    }
    
    # Copy profile
    Copy-Item "$PSScriptRoot\config\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
    
    # Copy Oh My Posh theme
    Copy-Item "$PSScriptRoot\themes\rgx.omp.json" "$env:USERPROFILE\rgx.omp.json" -Force
    
    Write-Host "PowerShell profile configured" -ForegroundColor Green
}

function Install-MicroConfig {
    Write-Host "Configuring Micro editor..." -ForegroundColor Cyan
    
    $microConfigPath = "$env:USERPROFILE\.config\micro"
    
    if (-not (Test-Path $microConfigPath)) {
        New-Item -ItemType Directory -Path $microConfigPath -Force | Out-Null
    }
    
    # Copy micro configurations
    Copy-Item "$PSScriptRoot\config\micro\*" $microConfigPath -Force -Recurse
    
    Write-Host "Micro editor configured" -ForegroundColor Green
}

function Install-AdminHotkey {
    Write-Host "Setting up admin terminal hotkey (Ctrl+Alt+T)..." -ForegroundColor Cyan
    
    # Copy scripts
    Copy-Item "$PSScriptRoot\scripts\OpenAdminTerminal.ps1" "$env:USERPROFILE\" -Force
    Copy-Item "$PSScriptRoot\scripts\OpenAdminTerminal.vbs" "$env:USERPROFILE\" -Force
    
    # Create shortcut
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Admin Terminal.lnk")
    $Shortcut.TargetPath = "$env:USERPROFILE\OpenAdminTerminal.vbs"
    $Shortcut.Hotkey = "CTRL+ALT+T"
    $Shortcut.IconLocation = "wt.exe"
    $Shortcut.Save()
    
    Write-Host "Admin hotkey configured" -ForegroundColor Green
}

# Main installation flow
try {
    Write-Host "Starting Raspberry Orgasm Terminal Theme installation..." -ForegroundColor Cyan
    Write-Host ""
    
    # Check if running as admin (recommended but not required)
    if (-not (Test-Administrator)) {
        Write-Host "WARNING: Not running as administrator. Some features may not install correctly." -ForegroundColor Yellow
        Write-Host "Press Ctrl+C to cancel and run as admin, or press Enter to continue..." -ForegroundColor Yellow
        Read-Host
    }
    
    # Install prerequisites
    if (-not $SkipPrerequisites) {
        Install-Prerequisites
    }
    
    # Install configurations
    Install-TerminalConfig
    Install-PowerShellProfile
    Install-MicroConfig
    Install-AdminHotkey
    
    Write-Host ""
    Write-Host "Installation completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Close and reopen Windows Terminal" -ForegroundColor White
    Write-Host "2. Use PowerShell 7 (pwsh) as your default shell" -ForegroundColor White
    Write-Host "3. Press Ctrl+Alt+T to test admin terminal hotkey" -ForegroundColor White
    Write-Host "4. Type 'Show-Hotkeys' in terminal to see all shortcuts" -ForegroundColor White
    Write-Host ""
    Write-Host "Enjoy your new terminal theme! 🍓" -ForegroundColor Magenta
    
} catch {
    Write-Host ""
    Write-Host "Installation failed: $_" -ForegroundColor Red
    Write-Host "Please check the error message and try again." -ForegroundColor Red
    exit 1
}