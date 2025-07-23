# Raspberry Orgasm PowerShell Terminal Theme Installer (Simple Version)
# By RGX Mods / RealmGX
# This version ONLY uses Windows PowerShell to avoid all compatibility issues

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
Write-Host "       ____                                     " -ForegroundColor Magenta
Write-Host "      / __ \_________ _____ ________ ___  ___  " -ForegroundColor DarkRed
Write-Host "     / / / / ___/ __ ``/ __ ``/ ___/ __ ``__ \/ __ \ " -ForegroundColor DarkRed
Write-Host "    / /_/ / /  / /_/ / /_/ (__  ) / / / / / / / /" -ForegroundColor DarkRed
Write-Host "    \____/_/   \__, /\__,_/____/_/ /_/ /_/_/ /_/ " -ForegroundColor Magenta
Write-Host "              /____/                              " -ForegroundColor Magenta
Write-Host ""
Write-Host "             PowerShell Terminal Theme" -ForegroundColor Gray
Write-Host ""
Write-Host "        RGX MODS by RealmGX" -ForegroundColor Cyan
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
    
    # Install Scoop
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
    
    # Find Windows Terminal installation
    $terminalPaths = @(
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState",
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState"
    )
    
    $terminalPath = $null
    foreach ($path in $terminalPaths) {
        if (Test-Path (Split-Path $path -Parent)) {
            $terminalPath = $path
            break
        }
    }
    
    if (-not $terminalPath) {
        Write-Host "Windows Terminal not found. Please install it first." -ForegroundColor Red
        Write-Host "Run: winget install Microsoft.WindowsTerminal" -ForegroundColor Yellow
        return
    }
    
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
    
    # ALWAYS use Windows PowerShell only configuration
    Write-Host "Downloading terminal settings (Windows PowerShell only)..." -ForegroundColor Yellow
    $settingsContent = (iwr -useb "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/config/terminal-settings-simple.json").Content
    $settingsContent | Out-File $settingsPath -Encoding UTF8
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
    
    # Download profile
    Write-Host "Downloading PowerShell profile..." -ForegroundColor Yellow
    $profileContent = (iwr -useb "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/config/Microsoft.PowerShell_profile.ps1").Content
    $profileContent | Out-File $PROFILE -Encoding UTF8
    
    # Download Oh My Posh theme
    Write-Host "Downloading Oh My Posh theme..." -ForegroundColor Yellow
    $themeContent = (iwr -useb "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/themes/rgx.omp.json").Content
    $themeContent | Out-File "$env:USERPROFILE\rgx.omp.json" -Encoding UTF8
    
    Write-Host "PowerShell profile configured" -ForegroundColor Green
    
    # Clean any corruption in existing profile
    Write-Host "Cleaning profile..." -ForegroundColor Yellow
    if (Test-Path $PROFILE) {
        $cleanProfile = Get-Content $PROFILE -Raw
        # Remove any potential corruption
        $cleanProfile = $cleanProfile -replace '[^\x00-\x7F]+', ''
        $cleanProfile | Out-File $PROFILE -Encoding UTF8 -Force
    }
}

function Install-MicroConfig {
    Write-Host "Configuring Micro editor..." -ForegroundColor Cyan
    
    $microConfigPath = "$env:USERPROFILE\.config\micro"
    
    if (-not (Test-Path $microConfigPath)) {
        New-Item -ItemType Directory -Path $microConfigPath -Force | Out-Null
    }
    
    Write-Host "Downloading micro configurations..." -ForegroundColor Yellow
    
    # Download bindings.json
    $bindingsContent = (iwr -useb "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/config/micro/bindings.json").Content
    $bindingsContent | Out-File "$microConfigPath\bindings.json" -Encoding UTF8
    
    # Download settings.json
    $settingsContent = (iwr -useb "https://raw.githubusercontent.com/donniedice/raspberry-orgasm-terminal/main/config/micro/settings.json").Content
    $settingsContent | Out-File "$microConfigPath\settings.json" -Encoding UTF8
    
    Write-Host "Micro editor configured" -ForegroundColor Green
}

function Install-AdminHotkey {
    Write-Host "Setting up admin terminal hotkey (Ctrl+Alt+T)..." -ForegroundColor Cyan
    
    # Create admin terminal scripts
    Write-Host "Creating admin terminal scripts..." -ForegroundColor Yellow
    
    # Create PowerShell script
    $ps1Content = @'
$terminal = New-Object -ComObject Shell.Application
$terminal.ShellExecute("wt.exe", "", "", "runas", 1)
'@
    $ps1Content | Out-File "$env:USERPROFILE\OpenAdminTerminal.ps1" -Encoding UTF8
    
    # Create VBS wrapper
    $vbsContent = @'
Set objShell = CreateObject("Wscript.Shell")
objShell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\OpenAdminTerminal.ps1""", 0, False
'@
    $vbsContent | Out-File "$env:USERPROFILE\OpenAdminTerminal.vbs" -Encoding ASCII
    
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
    Write-Host "(Windows PowerShell Edition - No Compatibility Issues!)" -ForegroundColor Green
    Write-Host ""
    
    # Check if running as admin
    $isAdmin = Test-Administrator
    if ($isAdmin) {
        Write-Host "Running as administrator. Some tools will be installed for current user." -ForegroundColor Cyan
    } else {
        Write-Host "Running as regular user. This is recommended for proper Scoop installation." -ForegroundColor Green
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
    Write-Host "2. Windows PowerShell is configured and ready" -ForegroundColor Green
    Write-Host "3. Press Ctrl+Alt+T to test admin terminal hotkey" -ForegroundColor White
    Write-Host "4. Type 'Show-Hotkeys' in terminal to see all shortcuts" -ForegroundColor White
    Write-Host ""
    Write-Host "Enjoy your new terminal theme!" -ForegroundColor Magenta
    
} catch {
    Write-Host ""
    Write-Host "Installation failed: $_" -ForegroundColor Red
    Write-Host "Please check the error message and try again." -ForegroundColor Red
    exit 1
}