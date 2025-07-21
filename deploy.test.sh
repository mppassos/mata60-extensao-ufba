#!/bin/bash
set -euo pipefail

DB_NAME="extensao_ufba"
DB_USER="postgres"
SQL_DIR="sql"
AUD_DIR="$SQL_DIR/auditoria"
PROC_DIR="$SQL_DIR/procedures"

echo "Deploy iniciado em $(date)"

psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS $DB_NAME;"
psql -U "$DB_USER" -c "CREATE DATABASE $DB_NAME;"

psql -U "$DB_USER" -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS pgcrypto;"
echo "➤ Extensão pgcrypto habilitada"

for file in \
  "01_DDL_Esquema_Tabelas.sql" \
  "02_DML_Populacao_Dados.sql" \
  "03_Indices_Consultas.sql" \
  "04_Materialized_Views.sql"; do
  echo "➤ Executando ${file}"
  psql -U "$DB_USER" -d "$DB_NAME" -f "$SQL_DIR/$file"
done

for file in \
  "$AUD_DIR"/FC_AUDITA_PARTICIPANTE.sql \
  "$AUD_DIR"/TA_AUDITORIA_LOG_PARTICIPANTE.sql; do
  echo "➤ Executando auditoria: $(basename "$file")"
  psql -U "$DB_USER" -d "$DB_NAME" -f "$file"
done

for file in \
  "$PROC_DIR"/SP_INSERE_PARTICIPANTE_COM_INSCRICAO.sql \
  "$PROC_DIR"/SP_CADASTRA_OU_ATUALIZA_FEEDBACK.sql \
  "$PROC_DIR"/SP_ATUALIZA_CERTIFICADOS.sql; do
  echo "➤ Executando procedure: $(basename "$file")"
  psql -U "$DB_USER" -d "$DB_NAME" -f "$file"
done

psql -U "$DB_USER" -d "$DB_NAME" -f "$SQL_DIR/07_Triggers_Auditoria.sql"
chmod +x "$SQL_DIR/05_REFRESH_VIEWS.sh"
bash "$SQL_DIR/05_REFRESH_VIEWS.sh"

echo "Scripts executados com sucesso"

psql -U "$DB_USER" -d "$DB_NAME" <<EOF
CALL SP_INSERE_PARTICIPANTE_COM_INSCRICAO('Teste Script','teste@ufba.br',1,1);
CALL SP_CADASTRA_OU_ATUALIZA_FEEDBACK(1,1,5,'Teste OK');
CALL SP_ATUALIZA_CERTIFICADOS(1);
SELECT * FROM mv_atividade_por_tipo LIMIT 3;
SELECT * FROM TA_AUDITORIA_LOG_PARTICIPANTE ORDER BY ID_LOG DESC LIMIT 3;
EOF

echo "Deploy e testes finais concluídos com sucesso!"
