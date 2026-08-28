# ==============================================================================
# Script de Equivalência Lógica - Synopsys Formality
# ==============================================================================


set DC_DIR $::env(DC_DIR)
set FM_DIR $::env(FM_DIR)
set RTL_DIR $::env(RTL_DIR)
set VERIF_DIR $::env(VERIF_DIR)
set ANC_DIGITAL_ROOT $::env(ANC_DIGITAL_ROOT)

set DESIGN_NAME "ANC"; 

# Caminhos Relativos de Diretorios
set DC_PATH "$DC_DIR/outputs"
set RPT_PATH "$FM_DIR/reports/pos_dft"

# Montagem Automatica dos Arquivos
set SVF_FILE "${DC_DIR}/design_dft.svf"
set MAPPED_FILE "${DC_DIR}/ANC_Netlist.v"; # netlist gerado na sintese pre dft
set MAPPED_DFT_FILE "${DC_DIR}/ANC_Netlist_DFT.v"; # netlist gerado na sintese pos dft

# Garante que a pasta de relatorios exista
if {![file exists $RPT_PATH]} { file mkdir -p $RPT_PATH }

# Setup Inicial e Bibliotecas
source "${ANC_DIGITAL_ROOT}/common/pdks/saed32/hvt.tcl"

set search_path "$search_path $DC_DIR"
set synopsys_auto_setup true
read_db $TARGET_LIBRARY

# Setup Verification Format
set_svf $SVF_FILE

# Referencia
read_verilog -container r -lib WORK $MAPPED_FILE
set_top r:/WORK/${DESIGN_NAME}
report_designs


# Implementation
read_verilog -container i -lib WORK $MAPPED_DFT_FILE
set_top i:/WORK/$DESIGN_NAME

match
verify

puts "--- Gerando relatorios em $RPT_PATH ---"

# Adicionamos o nome do design no relatorio para nao sobrescrever dados
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_guidance.rpt { report_guidance -summary }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_unmatched.rpt { report_unmatched_points }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_failing.rpt { report_failing_points }

exit