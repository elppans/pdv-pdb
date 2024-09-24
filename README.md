# pdv-pdb

# Script de Manutenção do Banco de Dados

Este script fornece várias opções para realizar manutenção em um banco de dados PostgreSQL, incluindo operações de `VACUUM`, `ANALYZE` e `REINDEX`.

## Uso

```sh
./pdv-pdb_organiza.sh [opção]
```

## Opções

- `--vacuum`, `-v`: Executa `vacuumdb`, `VACUUM` e `ANALYZE` no banco de dados completo.
- `--reindexdb`, `-r`: Executa `reindexdb` e `REINDEX` no banco de dados completo.
- `--vacuum-tables`, `-vt`: Executa `vacuumdb`, `VACUUM` e `ANALYZE` em tabelas específicas.
- `--reindexdb-tables`, `-rt`: Executa `reindexdb` e `REINDEX` em tabelas específicas.

## Exemplos

```sh
# Executa vacuumdb, VACUUM e ANALYZE no banco de dados completo
./pdv-pdb_organiza.sh --vacuum

# Executa reindexdb e REINDEX no banco de dados completo
./pdv-pdb_organiza.sh -r

# Executa vacuumdb, VACUUM e ANALYZE em tabelas específicas
./pdv-pdb_organiza.sh --vacuum-tables

# Executa reindexdb e REINDEX em tabelas específicas
./pdv-pdb_organiza.sh -rt
```

## Funções

- `vacuumdb_func`: Função que realiza `vacuumdb`, `VACUUM` e `ANALYZE` no banco de dados completo.
- `reindexdb_func`: Função que realiza `reindexdb` e `REINDEX` no banco de dados completo.
- `vacuumdb_tables_func`: Função que realiza `vacuumdb`, `VACUUM` e `ANALYZE` em tabelas específicas.
- `reindexdb_tables_func`: Função que realiza `reindexdb` e `REINDEX` em tabelas específicas.

## Notas

- Certifique-se de ter as permissões necessárias para executar essas operações no banco de dados.
