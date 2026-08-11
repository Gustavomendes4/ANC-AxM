# ==============================================================================
# Script de Equivalência Lógica - Synopsys Formality
# ==============================================================================


## TODO: Não alterei os paths aqui, pois ainda não vamos usar

################################################################################
# 0. Parametrização Global (Altere apenas este bloco para novos designs)
################################################################################
set DESIGN_NAME     "top_cpu"             ;# Nome do modulo topo
set RTL_EXT         ".sv"                 ;# Extensao do arquivo original (.sv ou .v)
set MAPPED_SUFFIX   "_mapped.v"           ;# Sufixo do netlist gerado na sintese

# Caminhos Relativos de Diretorios
set DC_PATH         "../../dc_nxt/outputs"
set RTL_FILELIST    "../../../verif/filelist_fm.f" ;# Apontando para o seu filelist.f
set RPT_PATH        "../rpt"

################################################################################
# Montagem Automatica dos Arquivos (Nao precisa alterar)
################################################################################
set SVF_FILE        "${DC_PATH}/${DESIGN_NAME}.svf"
set MAPPED_FILE     "${DC_PATH}/${DESIGN_NAME}${MAPPED_SUFFIX}"

# Garante que a pasta de relatorios exista
if {![file exists $RPT_PATH]} { file mkdir $RPT_PATH }

# ==============================================================================
# Setup Inicial e Bibliotecas
# ==============================================================================
source ../scripts/common_setup.tcl

set search_path "$search_path $ADDITIONAL_SEARCH_PATH $DC_PATH"
set synopsys_auto_setup true

# Le as bibliotecas da Foundry (Logica)
read_db $TARGET_LIBRARY_FILES

# ==============================================================================
# 1. Carregar SVF (Setup Verification Format)
# ==============================================================================
# Deve ser lido ANTES dos designs
set_svf $SVF_FILE

# ==============================================================================
# 2. Container de Referencia (Reference - RTL Original via Filelist)
# ==============================================================================
puts "--- Extraindo arquivos do $RTL_FILELIST ---"
set rtl_files [list]

# Abre o arquivo filelist para leitura
set fp [open $RTL_FILELIST r]
while {[gets $fp line] >= 0} {
    # Remove espacos em branco nas pontas
    set line [string trim $line]
    
    # Ignora linhas vazias e comentarios (iniciados com # ou //)
    if {$line != "" && ![regexp {^#|^//} $line]} {
        lappend rtl_files $line
    }
}
close $fp

# Le todos os arquivos coletados como uma unica lista no container de Referencia
if {$RTL_EXT == ".sv"} {
    read_sverilog -r $rtl_files
} else {
    read_verilog -r $rtl_files
}

# Define o topo apontando EXPLICITAMENTE para o container de Referencia (r:)
set_top r:/WORK/${DESIGN_NAME}

# ==============================================================================
# 3. Container de Implementacao (Implementation - Netlist Sintetizado)
# ==============================================================================
# Le o netlist em Verilog estrutural gerado pelo Design Compiler
read_verilog -i $MAPPED_FILE

# Define o topo apontando EXPLICITAMENTE para o container de Implementacao (i:)
set_top i:/WORK/${DESIGN_NAME}

# ==============================================================================
# 4. Execucao da Verificacao (Match & Verify)
# ==============================================================================
match
verify

# ==============================================================================
# 5. Geracao de Relatorios
# ==============================================================================
puts "--- Gerando relatorios em $RPT_PATH ---"

# Adicionamos o nome do design no relatorio para nao sobrescrever dados
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_guidance.rpt { report_guidance -summary }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_unmatched.rpt { report_unmatched_points }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_failing.rpt { report_failing_points }

puts "--- Formality Concluido ---"
exit