# Sistema de Gestão de Atividades de Extensão - UFBA (MATA60)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![SBC Format](https://img.shields.io/badge/Format-SBC_Book_Chapter-green)
![License: MIT](https://img.shields.io/badge/license-MIT-green)

Projeto acadêmico da disciplina **Banco de Dados (MATA60)** da **UFBA**, com foco em um sistema completo para gestão de atividades de extensão no Instituto de Computação. Modelagem, implementação em PostgreSQL e documentação em formato SBC.

---

## 📁 Estrutura do Projeto

```
.
├── docs/
│   ├── Relatorio_SBC.pdf
│   ├── MER_Completo.png
│   └── DicionarioDados.pdf
├── sql/
│   ├── 01_DDL_Esquema_Tabelas.sql
│   ├── 02_DML_Populacao_Dados.sql
│   └── 03_Indices_Consultas.sql
├── prints/Resultados_Consultas/
│   ├── Consulta1.png
│   ├── Consulta2.png
│   └── ...
├── README.md
└── LICENSE
```

---

## 🛠️ Pré-requisitos

- PostgreSQL 15 ou superior
- (Opcional) pgAdmin ou DBeaver para interface gráfica

---

## 🚀 Como Executar

```bash
# 1. Criar banco de dados
psql -U postgres -c "CREATE DATABASE extensao_ufba;"

# 2. Executar os scripts na ordem
psql -U postgres -d extensao_ufba -f sql/01_DDL_Esquema_Tabelas.sql
psql -U postgres -d extensao_ufba -f sql/02_DML_Populacao_Dados.sql
psql -U postgres -d extensao_ufba -f sql/03_Indices_Consultas.sql
```

---

## 🧪 Testes (SQL)

```sql
-- Contagem de registros
SELECT 'TB_ATIVIDADE' AS tabela, COUNT(*) FROM TB_ATIVIDADE
UNION ALL SELECT 'TB_FEEDBACK', COUNT(*) FROM TB_FEEDBACK
UNION ALL SELECT 'TB_CERTIFICADO', COUNT(*) FROM TB_CERTIFICADO;

-- Verificação de índices
SELECT indexname, indexdef FROM pg_indexes 
WHERE tablename IN ('tb_feedback', 'tb_certificado');

-- Consulta de feedbacks
SELECT f.ID_FEEDBACK, p.NM_PARTICIPANTE, a.DS_TITULO, f.VL_NOTA, f.DS_COMENTARIO
FROM TB_FEEDBACK f
JOIN TB_PARTICIPANTE p ON f.ID_PARTICIPANTE = p.ID_PARTICIPANTE
JOIN TB_ATIVIDADE a ON f.ID_ATIVIDADE = a.ID_ATIVIDADE;
```

---

## ✅ Requisitos Atendidos

| Funcionalidade                  | Script Relacionado                     |
|--------------------------------|----------------------------------------|
| Criação e gerenciamento de atividades | `01_DDL_Esquema_Tabelas.sql`     |
| Registro de participantes e presença | `02_DML_Populacao_Dados.sql`     |
| Emissão de certificados automáticos  | `02_DML_Populacao_Dados.sql`     |
| Coleta de feedbacks e análises       | `03_Indices_Consultas.sql`       |
| Otimização via índices               | `03_Indices_Consultas.sql`       |

---

## 📄 Licença

Este projeto está licenciado sob os termos da [MIT License](LICENSE).

---

## 🙌 Autor

**Matheus Pereira dos Passos Oliveira**  
Disciplina: Banco de Dados - MATA60  
Instituto de Computação - UFBA

---
**Projeto desenvolvido sob orientação do Prof. Robespierre Pita (MATA60 – Banco de Dados – UFBA).**

