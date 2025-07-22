# HIPAA Compliance Guide

## Overview

The Raspberry Orgasm Terminal Theme is designed with healthcare environments in mind, ensuring all operations remain local and compliant with HIPAA regulations for Protected Health Information (PHI).

## Compliance Features

### 🔒 Local Processing Only

All terminal operations and enhancements run entirely on your local machine:
- No cloud services required
- No external API calls
- No telemetry or data collection
- No internet connection needed after installation

### 🛡️ Security Features

1. **No Data Transmission**
   - All syntax highlighting happens locally
   - Terminal history stored only on your machine
   - No clipboard data sent externally
   - Configuration files remain local

2. **Audit Trail Compatible**
   - Works with Windows Event Logging
   - Compatible with Microsoft Purview
   - Supports PowerShell transcript logging
   - Integrates with enterprise logging solutions

3. **Access Control**
   - Respects Windows user permissions
   - No elevation of privileges
   - Admin terminal requires explicit authorization
   - File operations follow NTFS permissions

## HIPAA Configuration

### Enable Audit Logging

1. **PowerShell Transcript Logging**
```powershell
# Add to your profile for session logging
$logPath = "C:\Logs\PowerShell\$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
Start-Transcript -Path $logPath -Append
```

2. **Windows Event Logging**
```powershell
# Enable PowerShell script block logging
$basePath = 'HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
if (-not (Test-Path $basePath)) {
    New-Item $basePath -Force
}
Set-ItemProperty $basePath -Name EnableScriptBlockLogging -Value 1
```

3. **Command History Logging**
```powershell
# Set history save location
Set-PSReadLineOption -HistorySavePath "C:\Logs\PSHistory\ConsoleHost_history.txt"
```

### Secure Environment Variables

Ensure no sensitive data in environment:
```powershell
# Check for API keys or tokens
Get-ChildItem env: | Where-Object { $_.Name -match 'KEY|TOKEN|SECRET|PASSWORD' }

# Remove any found
Remove-Item env:OPENAI_API_KEY -ErrorAction SilentlyContinue
Remove-Item env:ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
```

### Disable External Features

For maximum security, disable any features that might reach external services:

1. **Disable Web Search in FZF**
```powershell
# Add to profile
$env:FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs'
```

2. **Disable Git Telemetry**
```powershell
git config --global core.telemetry false
```

3. **Local-Only Tools**
Configure tools to work offline:
```powershell
# Glow - use local files only
Set-Alias -Name glow -Value "glow --local"

# Bat - disable automatic updates
$env:BAT_PAGER = "less -RF"
```

## PHI Handling Best Practices

### 1. Never Store PHI in:
- PowerShell history
- Terminal buffer
- Configuration files
- Git repositories
- Environment variables

### 2. Secure Practices:
```powershell
# Clear sensitive command from history
Clear-History -CommandLine "*patient*"
Clear-History -CommandLine "*ssn*"
Clear-History -CommandLine "*medical*"

# Clear terminal buffer
Clear-Host

# Disable command history for sensitive session
Set-PSReadLineOption -HistorySaveStyle SaveNothing
```

### 3. Secure File Operations:
```powershell
# Use secure strings for sensitive data
$secureString = Read-Host "Enter sensitive data" -AsSecureString

# Encrypt files containing PHI
$content | ConvertTo-SecureString -AsPlainText -Force | 
    ConvertFrom-SecureString | Out-File "encrypted.txt"
```

## Audit and Monitoring

### Enable Comprehensive Logging

```powershell
# Create audit configuration
@'
# HIPAA Audit Configuration
$auditPath = "C:\AuditLogs\Terminal"
New-Item -ItemType Directory -Path $auditPath -Force -ErrorAction SilentlyContinue

# Log all commands
$ExecutionContext.SessionState.InvokeCommand.PreCommandLookupAction = {
    param($command, $lookup)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $env:USERNAME - $command" | Out-File "$auditPath\commands.log" -Append
}

# Log file access
$ExecutionContext.SessionState.Provider.Item.PreRemoveAction = {
    param($path)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $env:USERNAME - DELETE - $path" | Out-File "$auditPath\file-operations.log" -Append
}
'@ | Add-Content $PROFILE
```

### Integration with SIEM

Export logs for Security Information and Event Management:
```powershell
# Export terminal logs to SIEM format
function Export-TerminalAudit {
    param($StartDate, $EndDate)
    
    $logs = Get-ChildItem "C:\AuditLogs\Terminal\*.log" | 
        Where-Object { $_.LastWriteTime -ge $StartDate -and $_.LastWriteTime -le $EndDate }
    
    foreach ($log in $logs) {
        Get-Content $log | ConvertTo-Json | 
            Out-File "\\SIEM\Server\TerminalAudit_$(Get-Date -Format 'yyyyMMdd').json"
    }
}
```

## Verification Checklist

### Pre-Deployment Verification

- [ ] No external API endpoints configured
- [ ] All tools installed locally
- [ ] Audit logging enabled
- [ ] No telemetry services active
- [ ] File permissions properly set
- [ ] No PHI in configuration files
- [ ] Encryption at rest enabled
- [ ] Access controls verified

### Regular Audits

Monthly verification script:
```powershell
function Test-HIPAACompliance {
    Write-Host "HIPAA Compliance Check" -ForegroundColor Cyan
    
    # Check for external connections
    $external = netstat -an | Select-String ":443|:80" | Select-String -NotMatch "127.0.0.1|::1"
    if ($external) {
        Write-Host "WARNING: External connections detected" -ForegroundColor Red
        $external
    } else {
        Write-Host "✓ No external connections" -ForegroundColor Green
    }
    
    # Check for API keys
    $apiKeys = Get-ChildItem env: | Where-Object { $_.Name -match 'API|KEY|TOKEN' }
    if ($apiKeys) {
        Write-Host "WARNING: API keys found in environment" -ForegroundColor Red
        $apiKeys.Name
    } else {
        Write-Host "✓ No API keys in environment" -ForegroundColor Green
    }
    
    # Check audit logging
    if (Test-Path "C:\AuditLogs\Terminal") {
        Write-Host "✓ Audit logging directory exists" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Audit logging not configured" -ForegroundColor Red
    }
    
    # Check PowerShell logging
    $psLogging = Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -ErrorAction SilentlyContinue
    if ($psLogging.EnableScriptBlockLogging -eq 1) {
        Write-Host "✓ PowerShell logging enabled" -ForegroundColor Green
    } else {
        Write-Host "WARNING: PowerShell logging not enabled" -ForegroundColor Red
    }
}

# Run compliance check
Test-HIPAACompliance
```

## Emergency Procedures

### Data Breach Response

If PHI is accidentally exposed in terminal:

1. **Immediate Actions:**
```powershell
# Clear all terminal data
Clear-Host
Clear-History
Stop-Transcript

# Kill all terminal processes
Get-Process WindowsTerminal | Stop-Process -Force
```

2. **Cleanup:**
```powershell
# Remove history files
Remove-Item (Get-PSReadLineOption).HistorySavePath -Force
Remove-Item "C:\AuditLogs\Terminal\*" -Force

# Clear clipboard
Set-Clipboard -Value $null
```

3. **Report:**
- Document the incident
- Notify HIPAA Security Officer
- Review audit logs for extent of exposure

## Additional Resources

### HIPAA References
- [HHS HIPAA Security Rule](https://www.hhs.gov/hipaa/for-professionals/security/index.html)
- [NIST 800-66](https://csrc.nist.gov/publications/detail/sp/800-66/rev-1/final)

### Security Tools
- [Microsoft Purview](https://docs.microsoft.com/en-us/microsoft-365/compliance/microsoft-365-compliance-center)
- [Windows Security Auditing](https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/security-auditing-overview)

### Support
For HIPAA-specific questions about this terminal theme:
- Email: hipaa-support@realmgx.dev
- Include "HIPAA" in subject line
- Do not include PHI in communications