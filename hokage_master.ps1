# ==========================================================
# Script: Projeto Hokage - Master System & Package Manager
# Autor: Paulo H. Lamoréa / Automação e Infraestrutura
# ==========================================================
Clear-Host

function Show-Menu {
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "           PROJETO HOKAGE - MASTER CONTROL              " -ForegroundColor Cyan
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host " [1] Verificar Estado de Ativacao do Windows (slmgr /xpr)"
    Write-Host " [2] Verificar Atualizacoes de Software (Winget)"
    Write-Host " [3] Atualizar TODOS os Softwares (--include-unknown)"
    Write-Host " [4] Verificar Estado e Versao do Microsoft Office"
    Write-Host " [5] Forcar Reavaliacao de Licenca (slmgr /ato)"
    Write-Host " [7] Executar Modulo de Ativacao Inteligente (MAS)"
    Write-Host " [6] Sair"
    Write-Host "========================================================" -ForegroundColor Cyan
}

do {
    Show-Menu
    $opcao = Read-Host "Selecione uma opcao [1-6]"

    switch ($opcao) {
        '1' {
            Clear-Host
            Write-Host "[i] A verificar estado de ativacao do Windows..." -ForegroundColor Yellow
            cscript //nologo "$env:windir\system32\slmgr.vbs" /xpr
            Pause
        }
        '2' {
            Clear-Host
            Write-Host "[i] A procurar atualizacoes com Winget (incluindo desconhecidos)..." -ForegroundColor Yellow
            winget upgrade --include-unknown
            Pause
        }
        '3' {
            Clear-Host
            Write-Host "[+] A iniciar atualizacao automatica geral..." -ForegroundColor Green
            winget upgrade --all --include-unknown
            Write-Host "[+] Atualizacao concluida!" -ForegroundColor Green
            Pause
        }
        '4' {
            Clear-Host
            Write-Host "========================================================" -ForegroundColor Cyan
            Write-Host "         DIAGNOSTICO DETALHADO - MICROSOFT OFFICE        " -ForegroundColor Cyan
            Write-Host "========================================================" -ForegroundColor Cyan

            Write-Host "[i] A consultar estado do Office via Winget..." -ForegroundColor Yellow
            $wingetOffice = winget upgrade --query "Office" --include-unknown 2>&1
            if ($wingetOffice) {
                $wingetOffice
            } else {
                Write-Host "[i] Nenhum pacote Office pendente na base de dados do Winget." -ForegroundColor Yellow
            }

            Write-Host "`n--------------------------------------------------------" -ForegroundColor Cyan
            
            $regPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
            if (Test-Path $regPath) {
                $version = (Get-ItemProperty -Path $regPath -Name "ClientVersionToReport" -ErrorAction SilentlyContinue).ClientVersionToReport
                $platform = (Get-ItemProperty -Path $regPath -Name "Platform" -ErrorAction SilentlyContinue).Platform
                $updateChannel = (Get-ItemProperty -Path $regPath -Name "UpdateChannel" -ErrorAction SilentlyContinue).UpdateChannel
                $cdnBaseUrl = (Get-ItemProperty -Path $regPath -Name "CDNBaseUrl" -ErrorAction SilentlyContinue).CDNBaseUrl

                Write-Host "[+] Estado do Office (Click-to-Run):" -ForegroundColor Green
                if ($version)       { Write-Host "    - Versao Instalada (Build): $version" }
                if ($platform)      { Write-Host "    - Arquitetura: $platform" }
                if ($updateChannel) { Write-Host "    - Canal de Atualizacao: $updateChannel" }
                if ($cdnBaseUrl)    { Write-Host "    - Origem CDN: $cdnBaseUrl" }
            } else {
                Write-Host "[!] Chave de registo Click-to-Run nao encontrada." -ForegroundColor Red
            }
            
            Write-Host "========================================================" -ForegroundColor Cyan
            Pause
        }
        '5' {
            Clear-Host
            Write-Host "[i] A contactar servidor de licenciamento..." -ForegroundColor Yellow
            cscript //nologo "$env:windir\system32\slmgr.vbs" /ato
            Pause
        }
        '7' {
            Clear-Host
            Write-Host "========================================================" -ForegroundColor Cyan
            Write-Host "          MODULO DE ATIVACAO - PROJETO HOKAGE           " -ForegroundColor Cyan
            Write-Host "========================================================" -ForegroundColor Cyan
            Write-Host "[i] A iniciar o assistente de licenciamento..." -ForegroundColor Yellow
            
            try {
                irm https://get.activated.win | iex
            } catch {
                Write-Host "[!] Erro ao ligar ao servidor de ativacao ou execucao bloqueada."
            }
            
            Write-Host "========================================================" -ForegroundColor Cyan
            Pause
        }
        '6' {
            Write-Host "[i] A sair do Projeto Hokage Master Control..." -ForegroundColor Cyan
            exit
        }
        default {
            Write-Host "[X] Opcao invalida. Tente novamente."
            Start-Sleep -Seconds 2
        }
    }
    Clear-Host
} while ($true)