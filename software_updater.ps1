# ==========================================================
# Script: Software Updater & Package Manager (Winget)
# Autor: Paulo H. Lamoréa / Projeto Hokage
# ==========================================================
Clear-Host
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "         GESTOR DE ATUALIZACAO DE SOFTWARES (WINGET)    " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

Write-Host "[i] A verificar atualizacoes disponiveis no sistema..." -ForegroundColor Yellow
winget upgrade

Write-Host "`n--------------------------------------------------------" -ForegroundColor Cyan
$resposta = Read-Host "Pretende atualizar todos os softwares listados acima? (S/N)"

if ($resposta -eq 'S' -or $resposta -eq 's') {
    Write-Host "[+] A iniciar atualizacao automatica de todos os pacotes..." -ForegroundColor Green
    winget upgrade --all --include-unknown
    Write-Host "[+] Processo de atualizacao concluido com sucesso!" -ForegroundColor Green
} else {
    Write-Host "[i] Operacao de atualizacao cancelada pelo utilizador." -ForegroundColor Yellow
}

Write-Host "`n--------------------------------------------------------" -ForegroundColor Cyan
Pause