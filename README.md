# ⚡ Projeto Hokage - Automação & Infraestrutura

Repositório centralizado de scripts focados em automação de tarefas administrativas, diagnóstico de hardware, gestão de licenciamento e engenharia de dados.

---

## 📂 Estrutura Atualizada do Projeto

```text
📁 Projeto Hokage/
 ├── 📜 dashboard.bat            # Painel central interativo de sistema
 ├── 📜 license_manager.bat      # Utilitário de verificação e gestão de licença Windows
 ├── 📊 hardware_diagnostics.ps1 # Script PowerShell para diagnóstico de hardware e sistema
 ├── 📊 software_updater.ps1     # Gestor automatizado de atualizações via Winget
 └── 🐍 data_pipeline_logs.py    # Pipeline em Python para processamento e limpeza de logs

🚀 Como Executar

Antes de iniciares o painel mestre pela primeira vez na tua sessão do PowerShell, define a política de execução temporária para evitar bloqueios de segurança do sistema:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process
& ".\hokage_master.ps1"

