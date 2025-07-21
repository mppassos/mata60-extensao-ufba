CREATE OR REPLACE PROCEDURE SP_INSERE_PARTICIPANTE_COM_INSCRICAO(
  IN p_nm_participante VARCHAR,
  IN p_ds_email VARCHAR,
  IN p_id_tp_categoria INTEGER,
  IN p_id_atividade INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_id_participante INTEGER;
BEGIN
  SELECT ID_PARTICIPANTE INTO v_id_participante
  FROM TB_PARTICIPANTE
  WHERE DS_EMAIL = p_ds_email;

  IF v_id_participante IS NULL THEN
    INSERT INTO TB_PARTICIPANTE (NM_PARTICIPANTE, DS_EMAIL, ID_TP_CATEGORIA)
    VALUES (p_nm_participante, p_ds_email, p_id_tp_categoria)
    RETURNING ID_PARTICIPANTE INTO v_id_participante;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM RL_ATIVIDADE_PARTICIPANTE
    WHERE ID_ATIVIDADE = p_id_atividade AND ID_PARTICIPANTE = v_id_participante
  ) THEN
    INSERT INTO RL_ATIVIDADE_PARTICIPANTE (ID_ATIVIDADE, ID_PARTICIPANTE, IS_PRESENCA)
    VALUES (p_id_atividade, v_id_participante, FALSE);
  END IF;
END;
$$;
