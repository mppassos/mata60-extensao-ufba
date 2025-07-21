# Sistema de Gestão de Atividades de Extensão – UFBA (MATA60)

[📄 **Leia o Relatório SBC (PDF)**](https://mppassos.github.io/mata60-extensao-ufba/Relatorio_SBC.pdf)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Formato SBC](https://img.shields.io/badge/Format-SBC_book_chapter-green)
![License: MIT](https://img.shields.io/badge/license-MIT-green)

**Versão:** `v1.0-entrega2` • **Última atualização:** `Julho/2025`

---

## 📌 Descrição do Projeto

Sistema acadêmico para gestão de atividades de extensão promovidas pelo Instituto de Computação da UFBA. Desenvolvido na disciplina MATA60 – Banco de Dados, com foco em:

- Modelagem via ER e SQL padrão (PostgreSQL).
- Governança de dados, auditabilidade (PPP1), nomenclatura padronizada (MAD1) e backup incremental (PBR2).
- Rotinas otimizadas: stored procedures, triggers, materialized views, índices.
- Conformidade com LGPD, segurança e performance.

---

## ⚙️ Pré-requisitos

- PostgreSQL 15+
- (Opcional) Interface gráfica: pgAdmin, DBeaver ou similar
- Shell Bash (Linux/macOS/WSL)

---

## 🚀 Deploy Simplificado

Use o script `deploy_test.sh` para automatizar:

```bash
chmod +x deploy_test.sh
./deploy_test.sh
```

Ele executa:

    Criação do banco extensao_ufba

    Habilitação da extensão pgcrypto

    Criação de tabelas, índices, views, triggers e procedures

    População de dados de teste

    Atualização das materialized views

    Testes básicos de procedures, views e auditoria

💡 Testes Adicionais

Depois do deploy, você pode validar manualmente:

## Listar registros

SELECT
'TB*ATIVIDADE' AS tabela, COUNT(*) FROM tb*atividade
UNION ALL
SELECT
'TB_FEEDBACK', COUNT(*) FROM tb_feedback
UNION ALL
SELECT
'TB_CERTIFICADO', COUNT(\*) FROM tb_certificado;

## Conferir índices relevantes

SELECT indexname, indexdef
FROM pg_indexes WHERE tablename IN ('tb_feedback', 'tb_certificado');

## Consultar feedbacks

SELECT f.id_feedback, p.nm_participante, a.ds_titulo,
f.cd_nota, f.ds_comentario
FROM tb_feedback f
JOIN tb_participante p USING (id_participante)
JOIN tb_atividade a USING (id_atividade);

🛡️ Funcionalidades Cobertas

| Requisito                                     | Script                                             |
| --------------------------------------------- | -------------------------------------------------- |
| Modelo relacional, tabelas e constraints      | `01_DDL_Esquema_Tabelas.sql`                       |
| População para testes e dados iniciais        | `02_DML_Populacao_Dados.sql`                       |
| Índices e consultas analíticas                | `03_Indices_Consultas.sql`                         |
| Materia­lized Views (dashboards operacionais) | `04_Materialized_Views.sql`                        |
| Procedures de CRUD e lógica transacional      | `sql/procedures/*.sql`                             |
| Auditoria e compliance (PPP1)                 | `sql/auditoria/*.sql`, `07_Triggers_Auditoria.sql` |
| Backup incremental (PBR2)                     | `08_Backup_PBR2.sh`                                |

📚 Documentação SBC e Dicionário de Dados

Todos os artefatos detalhados estão em docs/, inclusive o PDF para visualização direta:

    Relatorio_SBC.pdf (versão SBC)

    Modelos conceitual e lógico

    Dicionário de dados e planilha de performance

🤝 Contribuição e Contato

Contribuições, dúvidas ou sugestões:

    Abra uma issue no GitHub

    Envie via Matheus Pereira dos Passos Oliveira (MATA60 – Robespierre Pita, IC‑UFBA)

🔐 Licença

Licenciado sob a MIT License – veja o arquivo LICENSE para mais informações.

Desenvolvido por Matheus Pereira dos Passos Oliveira
Orientador: Prof. Robespierre Pita (MATA60 – Banco de Dados – UFBA)
Finalizado em Julho de 2025 🚀
