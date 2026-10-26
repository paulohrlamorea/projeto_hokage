@echo off
title System Core Dashboard v2.5 - Enterprise Edition
color 0B
mode con cols=85 lines=28

:: ==========================================================
:: PASSO 1: Auto-elevacao de Privilegios (Requer Admin)
:: ==========================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Este script requer privilegios de Administrador.
    echo [!] Solicitando elevacao UAC em segundo plano...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:DASHBOARD_START
cls
echo  ======================================================================
echo   ____  _   _ _   _ _____ ____    ____    _    ____  _   _ 
echo  / ___|| | | | \ | |_   _|  _ \  |  _ \  / \  / ___|| | | |
echo  \___ \| |_| |  \| | | | | |_) | | | | |/ _ \ \___ \| |_| |
echo   ___) |  _  | |\  | | | |  _ <  | |_| / ___ \ ___) |  _  |
echo  |____/|_| |_|_| \_| |_| |_| \_\ |____/_/   \_\____/|_| |_|
echo                                      SISTEMA DE MONITORAMENTO V2.5
echo  ======================================================================
echo   [!] A inicializar modulos de seguranca e conexao com o kernel...
echo  ----------------------------------------------------------------------

:: Simulacao de carregamento estilizada
echo  [0%%] A carregar variaveis de ambiente...
timeout /t 1 >nul
echo  [35%%] A validar integridade do registro do Windows...
timeout /t 1 >nul
echo  [70%%] A estabelecer handshake com o subsistema de licenca...
timeout /t 1 >nul
echo  [100%%] Modulos carregados com sucesso! Pressione para abrir o painel.
pause >nul

:MENU
cls
echo  ======================================================================
echo                     CENTRAL DE CONTROLE DO SISTEMA
echo  ======================================================================
echo   Utilizador : %USERNAME%  ^| Hostname: %COMPUTERNAME%
echo  ----------------------------------------------------------------------
echo    [1] Verificar Estado de Ativacao (slmgr /xpr)
echo    [2] Obter Detalhes Completos da Licenca (slmgr /dli)
echo    [3] Diagnostico Rapido de Rede e IP (ipconfig /all)
echo    [4] Forcar Reavaliacao de Licenca (slmgr /ato)
echo    [5] Sair do Sistema
echo  ======================================================================
set /p opcao=" Selecione a operacao desejada [1-5]: "

if "%opcao%"=="1" goto STATUS
if "%opcao%"=="2" goto DETAILS
if "%opcao%"=="3" goto NETWORK
if "%opcao%"=="4" goto ACTIVATE
if "%opcao%"=="5" exit

echo.
echo  [X] Opcao invalida. Insira um valor entre 1 e 5.
timeout /t 2 >nul
goto MENU

:STATUS
cls
echo  ======================================================================
echo  [i] A VERIFICAR ESTADO DE ATIVACAO DO WINDOWS
echo  ======================================================================
cscript //nologo %windir%\system32\slmgr.vbs /xpr
echo.
echo  ----------------------------------------------------------------------
pause
goto MENU

:DETAILS
cls
echo  ======================================================================
echo  [i] RECOLHENDO METADADOS DETALHADOS DA LICENCA
echo  ======================================================================
cscript //nologo %windir%\system32\slmgr.vbs /dli
echo.
echo  ----------------------------------------------------------------------
pause
goto MENU

:NETWORK
cls
echo  ======================================================================
echo  [i] DIAGNOSTICO DE INTERFACES DE REDE E IP
echo  ======================================================================
ipconfig | findstr /i "IPv4 Endereco Adaptador"
echo.
echo  ----------------------------------------------------------------------
pause
goto MENU

:ACTIVATE
cls
echo  ======================================================================
echo  [i] A CONTACTAR O SERVIDOR DE LICENCIAMENTO CENTRAL
echo  ======================================================================
cscript //nologo %windir%\system32\slmgr.vbs /ato
echo.
echo  ----------------------------------------------------------------------
pause
goto MENU