#!/bin/bash

# Dê permissão de execução com o comando:
# chmod +x sql/08_Backup_PBR2.sh

# Diretório de destino (ajustável)
DESTINO_BACKUP="./backups/incrementais"
LOG="./backups/logs/backup_$(date +%F).log"

# Nome do banco e usuário
# Ajuste os valores conforme necessário
BANCO="extensao_ufba"
USUARIO="pg_bkpincrem"

# Criação do diretório, se não existir
mkdir -p "$DESTINO_BACKUP"
mkdir -p "$(dirname "$LOG")"

# Arquivo de saída incremental (com timestamp)
ARQUIVO="$DESTINO_BACKUP/incremental_$(date +%F_%H-%M).sql"

# Comando de backup incremental (simulado via pg_dump com schema e dados recentes)
echo "Iniciando backup incremental em $(date)" >> "$LOG"
pg_dump -U "$USUARIO" -F c -f "$ARQUIVO" -Z 9 "$BANCO" >> "$LOG" 2>&1

# Verificação de integridade básica
if [ -f "$ARQUIVO" ]; then
    echo "Backup realizado com sucesso: $ARQUIVO" >> "$LOG"
else
    echo "Erro: backup não foi gerado!" >> "$LOG"
fi
