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

## Configuração para o crontab
```ini
# Executar script para o backup automático No horario determinado
# 00   23  *  *  *  root /usr/bin/pdv-pdb_bkp_in_dir

# Executar Script para limpeza de backups antigos, de "N" dias ou mais, configurado na variável "DIAS", no horario determinado.
# 00   2  *  *  *  root /usr/bin/pdv-pdb_bkp_rm

# A cada 1 minuto, verificar HD Externo, se (des)montado no local configurado
# */1   *  *  *  *  root /usr/bin/pdv-pdb_pdev-automount

# A cada 1 minuto, verificar Compartilhamento para backup, se (des)montado no local configurado
#*/1   *  *  *  *  root /usr/bin/pdv-pdb_share-mount

# Executar script para o efetuar um VACUUM e depois REINDEX
# 55   0  *  *  *  root /usr/bin/pdv-pdb_vr # Executar todo dia as 00 Hs 55 Min
```

## Notas

- Certifique-se de ter as permissões necessárias para executar essas operações no banco de dados.
