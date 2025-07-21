--Resumo por tipo de atividade

CREATE MATERIALIZED VIEW mv_atividade_por_tipo AS
SELECT
  t.ds_tp_atividade AS tipo_atividade,
  COUNT(a.id_atividade) AS total_atividades,
  COUNT(DISTINCT rap.id_participante) AS total_participantes,
  ROUND(AVG(fb.cd_nota)::numeric, 1) AS media_feedback
FROM tb_atividade a
JOIN tb_tp_atividade t USING(id_tp_atividade)
LEFT JOIN rl_atividade_participante rap USING(id_atividade)
LEFT JOIN tb_feedback fb USING(id_atividade)
GROUP BY t.ds_tp_atividade;
CREATE UNIQUE INDEX idx_mv_atividade_tipo ON mv_atividade_por_tipo(tipo_atividade);

--Resumo por parceiro

CREATE MATERIALIZED VIEW mv_parceiro_resumo AS
SELECT p.nm_parceiro AS parceiro,
       COUNT(DISTINCT rap.id_atividade) AS atividades_patrocinadas,
       SUM(rap.vl_contribuicao)::numeric(12,2) AS total_contribuicao
FROM tb_parceiro p
JOIN rl_atividade_parceiro rap USING(id_parceiro)
GROUP BY p.nm_parceiro;
CREATE UNIQUE INDEX idx_mv_parceiro ON mv_parceiro_resumo(parceiro);

--Resumo de feedback por participante

CREATE MATERIALIZED VIEW mv_feedback_participante AS
SELECT par.nm_participante AS participante,
       COUNT(f.id_feedback) AS qt_feedbacks,
       ROUND(AVG(f.cd_nota)::numeric,1) AS media_nota
FROM tb_participante par
LEFT JOIN tb_feedback f USING(id_participante)
GROUP BY par.nm_participante;
CREATE UNIQUE INDEX idx_mv_feedback_participante ON mv_feedback_participante(participante);


--Lista de instrutores por atividade

CREATE MATERIALIZED VIEW mv_instrutores_por_atividade AS
SELECT a.id_atividade,
       a.ds_titulo AS atividade,
       STRING_AGG(i.nm_instrutor,', ' ORDER BY i.nm_instrutor) AS instrutores
FROM tb_atividade a
JOIN rl_atividade_instrutor rai USING(id_atividade)
JOIN tb_instrutor i USING(id_instrutor)
GROUP BY a.id_atividade, a.ds_titulo;
CREATE INDEX idx_mv_instrutores_ativ ON mv_instrutores_por_atividade(atividade);
