# ==========================================================
# Script: Log Sanitizer & Data Pipeline Helper
# Autor: Paulo H. Lamoréa
# ==========================================================
import os
import datetime

def process_system_logs(file_path):
    print(f"[{datetime.datetime.now()}] Iniciando pipeline de leitura e limpeza de logs...")
    
    if not os.path.exists(file_path):
        print(f"[!] Arquivo '{file_path}' nao encontrado. Gerando massa de dados de teste...")
        with open(file_path, "w", encoding="utf-8") as f:
            f.write("INFO: System initialized successfully\n")
            f.write("WARNING: High CPU load detected on main thread\n")
            f.write("ERROR: Failed to connect to telemetry database\n")
    
    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()
        
    critical_logs = [line.strip() for line in lines if "WARNING" in line or "ERROR" in line]
    
    print(f"[+] Total de ocorrencias criticas filtradas: {len(critical_logs)}")
    for idx, log in enumerate(critical_logs, 1):
        print(f"    ({idx}) {log}")
        
    return critical_logs

if __name__ == "__main__":
    process_system_logs("system_diagnostics.log")