#!/bin/bash

# Script de atualização das views materializadas do sistema de extensão universitária
#Garanta que ele tenha permissão de execução:
#chmod +x sql/05_REFRESH_VIEWS.sh

echo "Atualizando materialized views..."

#Favor verificar se o nome do banco de dados está correto
psql -U postgres -d extensao_ufba -c "REFRESH MATERIALIZED VIEW mv_atividade_por_tipo;"
psql -U postgres -d extensao_ufba -c "REFRESH MATERIALIZED VIEW mv_parceiro_resumo;"
psql -U postgres -d extensao_ufba -c "REFRESH MATERIALIZED VIEW mv_feedback_participante;"
psql -U postgres -d extensao_ufba -c "REFRESH MATERIALIZED VIEW mv_instrutores_por_atividade;"

echo "Todas as views foram atualizadas com sucesso."
