#!/bin/bash

# Adaptação dos seguintes Scripts de "customshell":
# zdb_vacuum_analyze_reindex_db.sh
# zdb_vacuum_analyze_db_tables_cnfe-nheader-nitem.sh
# zdb_reindex_db_tables_nfe-header-item.sh

# Verificando se é Super Usuário
if [ "$(id -u)" != "0" ]; then
echo "Deve executar o comando como super usuario!"
exit 0
fi

##      Usando arquivo de log - INÍCIO

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "/var/log/"${0##*/}".log")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "/var/log/"${0##*/}"_error.log")

##      Usando arquivo de log - FIM

# Variáveis para configuração geral
opcao="$1"
ip="127.0.0.1"
port="5432"
banco="NomeBanco"
usuario="UsuarioBanco"

# Exportação das variáveis
export opcao
export ip
export port
export banco
export usuario

# Fazer vacuumdb, VACUUM e ANALYZE no banco, completo:
vacuumdb_func() {
echo -e "Iniciando VACUUM - $(date)..."
vacuumdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -v -f -z
echo -e "Finalizado VACUUM - $(date)"
}
 
# Fazer reindexdb, REINDEX no banco, completo:
reindexdb_func() {
echo "REINDEXANDO banco - $(date)..."
reindexdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco"
echo -e "REINDEX FINALIZADO - $(date)..."
 }
 
# Fazer vacuumdb, VACUUM e ANALYZE em tabelas expecificas
vacuumdb_tables_func() {
echo -e "Iniciando VACUUM Tables - $(date)..."
vacuumdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -v -f -z -t public.tab_controle_nfe
vacuumdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -v -f -z -t public.tab_nota_header
vacuumdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -v -f -z -t public.tab_nota_item
echo -e "Finalizado VACUUM Tables - $(date)"
}

# Fazer reindexdb, REINDEX em tabelas expecificas
vacuumdb_tables_func() {
echo -e "Iniciando REINDEX Tables - $(date)..."
reindexdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -t public.tab_controle_nfe
reindexdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -t public.tab_nota_header
reindexdb -h "$ip" -p "$port" -U "$usuario" -w -d "$banco" -t public.tab_nota_item
echo -e "Finalizado REINDEX Tables - $(date)"
}

# Função para exibir o help
mostrar_help() {
    echo "Uso: $0 [opção]"
    echo
    echo "Opções:"
    echo "  --vacuum, -v           Fazer vacuumdb, VACUUM e ANALYZE no banco, completo"
    echo "  --reindexdb, -r        Fazer reindexdb, REINDEX no banco, completo"
    echo "  --vacuum-tables, -vt   Fazer vacuumdb, VACUUM e ANALYZE em tabelas específicas"
    echo "  --reindexdb-tables, -rt Fazer reindexdb, REINDEX em tabelas específicas"
    echo
    echo "Exemplos:"
    echo "  $0 --vacuum"
    echo "  $0 -r"
    echo "  $0 --vacuum-tables"
    echo "  $0 -rt"
}

# Verifica se nenhuma opção foi passada
if [ $# -eq 0 ]; then
    mostrar_help
    exit 1
fi

# Processa as opções
case "$1" in
    --vacuum|-v)
        # Fazer vacuumdb, VACUUM e ANALYZE no banco, completo:
        vacuumdb_func
        ;;
    --reindexdb|-r)
        # Fazer reindexdb, REINDEX no banco, completo:
        reindexdb_func
        ;;
    --vacuum-tables|-vt)
        # Fazer vacuumdb, VACUUM e ANALYZE em tabelas específicas:
        vacuumdb_tables_func
        ;;
    --reindexdb-tables|-rt)
        # Fazer reindexdb, REINDEX em tabelas específicas:
        reindexdb_tables_func
        ;;
    --help|-h)
        mostrar_help
        exit 0
        ;;
    *)
        echo "Opção inválida"
        mostrar_help
        exit 1
        ;;
esac
