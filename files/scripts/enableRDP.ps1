Write-Host "Включение Remote Desktop..." -ForegroundColor Green

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Write-Host "RDP успешно включен!" -ForegroundColor Green
Write-Host "Порт: 3389" -ForegroundColor Cyan

$RDPStatus = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections"
if ($RDPStatus.fDenyTSConnections -eq 0) {
    Write-Host "Статус RDP: Включен" -ForegroundColor Green
} else {
    Write-Host "Статус RDP: Отключен" -ForegroundColor Red
}
