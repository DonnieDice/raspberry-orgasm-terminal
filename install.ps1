# Raspberry Orgasm PowerShell Terminal Theme Installer
# By RGX Mods / RealmGX

param(
    [switch]$SkipPrerequisites,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Display ASCII banner
Write-Host ""
Write-Host "    ____                 __                       " -ForegroundColor Magenta
Write-Host "   / __ \____ ________  / /_  ___  ____________  " -ForegroundColor DarkRed
Write-Host "  / /_/ / __ ``/ ___/ / / / __ \/ _ \/ ___/ ___/ / / /" -ForegroundColor DarkRed
Write-Host " / _, _/ /_/ (__  ) /_/ / /_/ /  __/ /  / /  / /_/ / " -ForegroundColor DarkRed
Write-Host "/_/ |_|\__,_/____/ .___/_.___/\___/_/  /_/   \__, /  " -ForegroundColor Magenta
Write-Host "                /_/                          /____/   " -ForegroundColor Magenta
Write-Host ""
Write-Host "  ____                                     " -ForegroundColor Magenta
Write-Host " / __ \_________ _____ ________ ___  ___  " -ForegroundColor DarkRed
Write-Host "/ / / / ___/ __ ``/ __ ``/ ___/ __ ``__ \/ __ \ " -ForegroundColor DarkRed
Write-Host "/ /_/ / /  / /_/ / /_/ (__  ) / / / / / / / /" -ForegroundColor DarkRed
Write-Host "\____/_/   \__, /\__,_/____/_/ /_/ /_/_/ /_/ " -ForegroundColor Magenta
Write-Host "          /____/                              " -ForegroundColor Magenta
Write-Host ""
Write-Host "          PowerShell Terminal Theme" -ForegroundColor Gray
Write-Host ""
Write-Host "        " -NoNewline
Write-Host "R" -ForegroundColor DarkRed -NoNewline
Write-Host "G" -ForegroundColor DarkRed -NoNewline
Write-Host "X" -ForegroundColor DarkRed -NoNewline
Write-Host " MODS " -ForegroundColor Cyan -NoNewline
Write-Host "by " -ForegroundColor Blue -NoNewline
Write-Host "R" -ForegroundColor DarkRed -NoNewline
Write-Host "e" -ForegroundColor Blue -NoNewline
Write-Host "a" -ForegroundColor Blue -NoNewline
Write-Host "l" -ForegroundColor Blue -NoNewline
Write-Host "m" -ForegroundColor Blue -NoNewline
Write-Host "G" -ForegroundColor DarkRed -NoNewline
Write-Host "X" -ForegroundColor DarkRed
Write-Host "        ====================" -ForegroundColor DarkMagenta
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
        @{id = "BurntSushi.ripgrep.MSVC"; name = "ripgrep"},
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
    
    # Install Scoop (handle admin detection)
    try {
        $scoop = Get-Command scoop -ErrorAction SilentlyContinue
        if (-not $scoop) {
            Write-Host "Installing Scoop package manager..." -ForegroundColor Yellow
            
            # Check if running as admin and install accordingly
            if (Test-Administrator) {
                # Install for current user even when admin
                $env:SCOOP = "$env:USERPROFILE\scoop"
                [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
                iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
            } else {
                Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
                iwr -useb get.scoop.sh | iex
            }
            
            # Add to PATH
            $env:Path = "$env:USERPROFILE\scoop\shims;$env:Path"
        }
    } catch {
        Write-Host "Failed to install Scoop: $_" -ForegroundColor Red
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