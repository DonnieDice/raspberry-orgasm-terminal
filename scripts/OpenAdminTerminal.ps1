$terminal = New-Object -ComObject Shell.Application
$terminal.ShellExecute("wt.exe", "", "", "runas", 1)