-- 1. Limpeza de dados (caso o script seja reexecutado)
TRUNCATE TABLE 
    TB_FEEDBACK,
    TB_CERTIFICADO,
    RL_ATIVIDADE_INSTRUTOR,
    RL_ATIVIDADE_PARCEIRO,
    RL_ATIVIDADE_PARTICIPANTE,
    TB_ATIVIDADE,
    TB_PARTICIPANTE,
    TB_INSTRUTOR,
    TB_PARCEIRO
CASCADE;

-- População das tabelas principais
INSERT INTO TB_ATIVIDADE (DS_TITULO, DT_INICIO, DT_FIM, TP_ATIVIDADE, DS_LOCAL) 
VALUES 
('Workshop de PostgreSQL', '2025-05-20 14:00:00', '2025-05-20 18:00:00', 'WORKSHOP', 'Lab. 5 - IC-UFBA'),
('Minicurso de Python', '2025-06-10 09:00:00', '2025-06-12 12:00:00', 'MINICURSO', 'Sala 101 - IC-UFBA');

INSERT INTO TB_PARTICIPANTE (NM_PARTICIPANTE, DS_EMAIL, TP_CATEGORIA) 
VALUES 
('Ana Silva', 'ana.silva@ufba.br', 'ALUNO'),
('Carlos Oliveira', 'carlos.oliveira@gmail.com', 'COMUNIDADE');

-- População de instrutores e parceiros
INSERT INTO TB_INSTRUTOR (NM_INSTRUTOR, DS_AFILIACAO, DS_ESPECIALIDADE) 
VALUES 
('Prof. João Santos', 'UFBA - Departamento de Ciência da Computação', 'Bancos de Dados'),
('Dra. Maria Fernandes', 'Empresa Tech Solutions', 'Inteligência Artificial');

INSERT INTO TB_PARCEIRO (NM_PARCEIRO, TP_PARCEIRO, VL_CONTRIBUICAO) 
VALUES 
('Oracle Academy', 'PATROCINADOR', 5000.00),
('Google Developer Group', 'APOIADOR', NULL);

-- População das tabelas associativas
INSERT INTO RL_ATIVIDADE_PARTICIPANTE (ID_ATIVIDADE, ID_PARTICIPANTE, ST_PRESENCA) 
VALUES 
(1, 1, TRUE),
(1, 2, FALSE);

INSERT INTO RL_ATIVIDADE_INSTRUTOR (ID_ATIVIDADE, ID_INSTRUTOR, TP_PAPEL) 
VALUES 
(1, 1, 'MINISTRANTE'),
(2, 2, 'COORDENADOR');

INSERT INTO RL_ATIVIDADE_PARCEIRO (ID_ATIVIDADE, ID_PARCEIRO, VL_CONTRIBUICAO) 
VALUES 
(1, 1, 2000.00),
(2, 2, 1000.00);

-- População de certificados (após atividade concluída)
INSERT INTO TB_CERTIFICADO (CD_HASH, DT_EMISSAO, ID_ATIVIDADE, ID_PARTICIPANTE) 
VALUES 
('a1b2c3d4e5f6', '2025-05-21', 1, 1);

INSERT INTO TB_FEEDBACK (VL_NOTA, DS_COMENTARIO, ID_ATIVIDADE, ID_PARTICIPANTE)
VALUES 
(5, 'Excelente workshop!', 1, 1),
(4, 'Bom conteúdo, mas faltou tempo', 1, 2);



