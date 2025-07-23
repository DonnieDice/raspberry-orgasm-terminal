# Performance Optimization Guide

## Overview

The Raspberry Orgasm Terminal Theme is designed to be lightweight and fast while providing rich features. This guide helps you optimize performance for your specific needs.

## Startup Performance

### Baseline Metrics
- Cold start: ~2 seconds
- Warm start: <1 second
- Memory usage: ~80-100MB
- CPU idle: <5%

### Optimization Tips

#### 1. Disable Unused Features

Edit your PowerShell profile to comment out features you don't use:

```powershell
# Comment out if you don't use fuzzy finding
# $env:FZF_DEFAULT_OPTS="..."

# Comment out if you don't use smart cd
# if (Get-Command zoxide -ErrorAction SilentlyContinue) {
#     Invoke-Expression (& { (zoxide init powershell | Out-String) })
#     Set-Alias -Name cd -Value z -Force
# }
```

#### 2. Optimize Oh My Posh

Use a simpler prompt for faster rendering:

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "alignment": "left",
      "segments": [
        {
          "style": "plain",
          "template": "{{ .UserName }}@{{ .HostName }} {{ .Path }} > ",
          "type": "session"
        }
      ],
      "type": "prompt"
    }
  ],
  "version": 2
}
```

#### 3. Reduce Transparency

Disable acrylic for better performance:

```json
"useAcrylic": false,
"opacity": 100
```

## Memory Optimization

### Reduce History Size

```powershell
Set-PSReadLineOption -MaximumHistoryCount 1000
```

### Disable Prediction

If you don't need predictive text:

```powershell
Set-PSReadLineOption -PredictionSource None
```

### Limit Module Loading

Only load modules you need:

```powershell
# Instead of loading everything, be selective
Import-Module PSReadLine
# Import-Module other-module only if needed
```

## GPU Acceleration

### Enable Hardware Acceleration

In Windows Terminal settings:

```json
"experimental.rendering.forceFullRepaint": false,
"experimental.rendering.software": false
```

### Disable Effects for Low-End GPUs

```json
"useAcrylic": false,
"backgroundImageOpacity": 0,
"cursorShape": "bar"
```

## Network Performance

### Disable Remote Features

If working offline or on slow networks:

```powershell
# Disable git status in prompt
oh-my-posh init pwsh --config "$env:USERPROFILE\rgx-minimal.omp.json" | Invoke-Expression
```

## Battery Optimization

### Power Saving Mode

Create a power-saving profile:

```powershell
function Enable-PowerSaving {
    # Disable expensive features
    Set-PSReadLineOption -PredictionSource None
    Set-PSReadLineOption -ShowToolTips:$false
    
    # Use minimal prompt
    oh-my-posh init pwsh --config "$env:USERPROFILE\rgx-minimal.omp.json" | Invoke-Expression
    
    Write-Host "Power saving mode enabled" -ForegroundColor Green
}
```

### Reduce Refresh Rate

Lower terminal refresh rate:

```json
"experimental.rendering.forceFullRepaint": false,
"launchMode": "default"
```

## Benchmarking

### Test Startup Time

```powershell
Measure-Command { pwsh -NoProfile -Command "exit" }
Measure-Command { pwsh -Command "exit" }
```

### Monitor Resource Usage

```powershell
function Get-TerminalStats {
    $process = Get-Process WindowsTerminal
    [PSCustomObject]@{
        "Memory (MB)" = [math]::Round($process.WorkingSet64 / 1MB, 2)
        "CPU %" = [math]::Round($process.CPU, 2)
        "Handles" = $process.HandleCount
        "Threads" = $process.Threads.Count
    }
}
```

## Troubleshooting Performance Issues

### High CPU Usage

1. Check for infinite loops in profile
2. Disable git status in prompt for large repos
3. Reduce transparency effects

### Slow Startup

1. Profile your startup:
```powershell
pwsh -NoProfile -Command "Measure-Script { . $PROFILE }"
```

2. Lazy load modules:
```powershell
# Instead of immediate loading
function bat { 
    if (-not (Get-Command bat -ErrorAction SilentlyContinue)) {
        Write-Host "Loading bat..." -ForegroundColor Yellow
        # Load bat here
    }
    & bat @args
}
```

### Memory Leaks

1. Restart terminal periodically
2. Clear command history:
```powershell
Clear-History
[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
```

## Performance Profiles

### Minimal Profile

For maximum performance:

```powershell
# Minimal profile - fastest startup
$PSDefaultParameterValues['*:ErrorAction'] = 'SilentlyContinue'

# Basic prompt only
function prompt {
    "$PWD> "
}

# Essential aliases only
Set-Alias ll ls
Set-Alias g git
```

### Balanced Profile

Good performance with features:

```powershell
# Load only essential modules
Import-Module PSReadLine -MinimumVersion 2.0

# Simple prompt with git
oh-my-posh init pwsh --config "$env:USERPROFILE\rgx-simple.omp.json" | Invoke-Expression

# Core aliases
Set-Alias -Name ls -Value lsd -Force
Set-Alias -Name cat -Value bat -Force
```

### Full Profile

All features enabled (default).

## Best Practices

1. **Regular Maintenance**
   - Clear cache monthly: `Clear-Host; Clear-History`
   - Update tools quarterly
   - Review and remove unused aliases

2. **Monitor Performance**
   - Use Task Manager to check resource usage
   - Profile startup time after changes
   - Test on battery vs plugged in

3. **Optimize for Your Workflow**
   - Disable features you don't use
   - Customize based on your hardware
   - Consider different profiles for different tasks

## Hardware Recommendations

### Minimum
- CPU: Dual-core 2GHz
- RAM: 4GB
- GPU: DirectX 11 support

### Recommended
- CPU: Quad-core 2.5GHz+
- RAM: 8GB+
- GPU: Dedicated graphics
- SSD for faster loading

### Optimal
- CPU: Modern multi-core
- RAM: 16GB+
- GPU: DirectX 12 with acceleration
- NVMe SSD

## Conclusion

The Raspberry Orgasm Terminal Theme is designed to be performant out of the box. Use these optimizations only if you experience issues or need to maximize battery life/performance for specific scenarios.