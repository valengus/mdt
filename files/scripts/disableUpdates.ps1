Stop-Service -Name wuauserv -Force
Set-Service -Name wuauserv -StartupType Disabled
