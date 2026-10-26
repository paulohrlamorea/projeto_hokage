# ==========================================================
# Script: System Performance & Hardware Diagnostics
# Autor: Paulo H. Lamoréa
# ==========================================================
Clear-Host
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "         DIAGNOSTICO DE HARDWARE E SISTEMA              " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor
$gpu = Get-CimInstance Win32_VideoController
$ramTotal = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)

Write-Host "[+] Sistema Operacional : $($os.Caption)" -ForegroundColor Green
Write-Host "[+] Processador         : $($cpu.Name)" -ForegroundColor Green
Write-Host "[+] Placa de Video      : $($gpu.Name)" -ForegroundColor Green
Write-Host "[+] Memoria RAM Total   : $ramTotal GB" -ForegroundColor Green

Write-Host "`n[i] Varredura de sistema concluída com sucesso." -ForegroundColor Yellow
Pause