@echo off
:: ==========================================================
:: Tool: System License & Activation Utility v1.2
:: Author: Paulo H. Lamoréa / Automacao e Infraestrutura
:: ==========================================================
title Gestor de Licenciamento do Sistema - Automacao
color 0A

:: ----------------------------------------------------------
:: PASSO 1: Auto-elevacao de Privilegios (Verifica Admin)
:: ----------------------------------------------------------
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Este script requer privilegios de Administrador.
    echo [!] Solicitando elevacao de privilegios UAC...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MAIN_MENU
cls
echo ==========================================================
echo                GESTOR DE LICENCIAMENTO DO SO
echo ==========================================================
echo   [1] Verificar Estado de Ativacao (slmgr /xpr)
echo   [2] Obter Detalhes Completos da Licenca (slmgr /dli)
echo   [3] Forcar Reavaliacao / Conexao KMS (slmgr /ato)
echo   [4] Sair do Sistema
echo ==========================================================
set /p opcao="Selecione uma opcao do menu [1-4]: "

if "%opcao%"=="1" goto STATUS
if "%opcao%"=="2" goto DETAILS
if "%opcao%"=="3" goto ACTIVATE
if "%opcao%"=="4" exit

echo [X] Opcao invalida. Tente novamente em instantes.
timeout /t 2 >nul
goto MAIN_MENU

:STATUS
cls
echo ==========================================================
echo [i] A verificar o estado da ativacao do Windows...
echo ==========================================================
cscript //nologo %windir%\system32\slmgr.vbs /xpr
echo.
pause
goto MAIN_MENU

:DETAILS
cls
echo ==========================================================
echo [i] A recolher informacoes detalhadas da licenca...
echo ==========================================================
cscript //nologo %windir%\system32\slmgr.vbs /dli
echo.
pause
goto MAIN_MENU

:ACTIVATE
cls
echo ==========================================================
echo [i] A tentar reativar / contactar o servidor de licenciamento...
echo ==========================================================
cscript //nologo %windir%\system32\slmgr.vbs /ato
echo.
pause
goto MAIN_MENU