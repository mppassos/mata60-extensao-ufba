CREATE OR REPLACE PROCEDURE SP_CADASTRA_OU_ATUALIZA_FEEDBACK(
  IN p_id_atividade INTEGER,
  IN p_id_participante INTEGER,
  IN p_cd_nota INTEGER,
  IN p_ds_comentario TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM TP_NOTA WHERE CD_NOTA = p_cd_nota) THEN
    RAISE EXCEPTION 'Nota inválida: %', p_cd_nota;
  END IF;

  IF EXISTS (
    SELECT 1 FROM TB_FEEDBACK
    WHERE ID_ATIVIDADE = p_id_atividade AND ID_PARTICIPANTE = p_id_participante
  ) THEN
    UPDATE TB_FEEDBACK
    SET CD_NOTA = p_cd_nota,
        DS_COMENTARIO = p_ds_comentario
    WHERE ID_ATIVIDADE = p_id_atividade
      AND ID_PARTICIPANTE = p_id_participante;
  ELSE
    INSERT INTO TB_FEEDBACK (CD_NOTA, DS_COMENTARIO, ID_ATIVIDADE, ID_PARTICIPANTE)
    VALUES (p_cd_nota, p_ds_comentario, p_id_atividade, p_id_participante);
  END IF;
END;
$$;
