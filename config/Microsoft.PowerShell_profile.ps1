# RGX Mods by RealmGX Terminal
try {
    oh-my-posh init pwsh --config "$env:USERPROFILE\rgx.omp.json" | Invoke-Expression
} catch {
    Write-Host "Oh My Posh initialization failed" -ForegroundColor Yellow
}

# Enhanced Aliases from Rice Guide
# Only set aliases if the tools are actually installed
$microPath = "$env:USERPROFILE\scoop\shims\micro.exe"
if (Test-Path $microPath) {
    Set-Alias -Name nano -Value $microPath -Force
    Set-Alias -Name vim -Value $microPath -Force
    Set-Alias -Name notepad -Value $microPath -Force
}

if (Get-Command lsd -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value lsd -Force
    Set-Alias -Name ll -Value lsd -Force
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat -Force
}

if (Get-Command rg -ErrorAction SilentlyContinue) {
    Set-Alias -Name grep -Value rg -Force
}

# Git Aliases
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m "$m" }
function gp { git push }
function gl { git log --oneline --graph --decorate }

# Quick Functions
function touch { param($file) New-Item -ItemType File -Name $file }
function mkcd { param($dir) mkdir $dir; cd $dir }
function .. { cd .. }
function ... { cd ../.. }
function home { cd ~ }
function reload { . $PROFILE }

# Enhanced PSReadLine with All Features
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
# Keep default Alt+Del for forward delete word

# RGX Colors for PSReadLine
Set-PSReadLineOption -Colors @{
    Command = "#e30b5c"
    Parameter = "#db2777"
    Operator = "#c21e56"
    Variable = "#ec4899"
    String = "#ff4569"
    Number = "#ff1744"
    Type = "#a21caf"
    Comment = "#9d7ba8"
    Keyword = "#00b4d8"
    Error = "DarkRed"
    Selection = "`e[7m"
    InlinePrediction = "#52416b"
}

# FZF Integration
$env:FZF_DEFAULT_OPTS="--height 40% --layout=reverse --info=inline --border --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# Zoxide Integration (Smart CD)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
    Set-Alias -Name cd -Value z -Force
}

# Raspberry Orgasm ASCII with PowerShell Terminal Theme subtitle
Clear-Host
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
Write-Host "        ════════════════════" -ForegroundColor DarkMagenta
Write-Host ""

# Show hotkeys help
function Show-Hotkeys {
    Write-Host "🔥 RGX Terminal Hotkeys:" -ForegroundColor Cyan
    Write-Host "  Ctrl+` = Quake dropdown mode" -ForegroundColor Gray
    Write-Host "  F11 = Focus mode" -ForegroundColor Gray
    Write-Host "  Ctrl+Shift+- = Split horizontal" -ForegroundColor Gray
    Write-Host "  Ctrl+Shift+\ = Split vertical" -ForegroundColor Gray
    Write-Host "  Alt+Enter = Zoom pane" -ForegroundColor Gray
    Write-Host "  Ctrl+F = Search" -ForegroundColor Gray
    Write-Host "  Ctrl+L = Clear screen" -ForegroundColor Gray
    Write-Host "  Ctrl+Alt+T = Admin terminal" -ForegroundColor Gray
    Write-Host ""
}

# Terminal ready message
Write-Host "Type 'Show-Hotkeys' for shortcuts" -ForegroundColor DarkGray
Write-Host ""