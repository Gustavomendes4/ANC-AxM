# ==============================================================================
# Script de Equivalência Lógica - Synopsys Formality
# ==============================================================================


set DC_DIR $::env(DC_DIR)
set FM_DIR $::env(FM_DIR)
set RTL_DIR $::env(RTL_DIR)
set VERIF_DIR $::env(VERIF_DIR)

set DESIGN_NAME "ANC"; 
set NETLIST_NAME "ANC_Netlist.v"; # netlist gerado na sintese 

# Caminhos Relativos de Diretorios
set DC_PATH "$DC_DIR/outputs"
set RTL_FILELIST "$VERIF_DIR/filelist_fm.f"; # Apontando para o seu filelist.f
set RPT_PATH "$FM_DIR/reports/pre_dft"


# Montagem Automatica dos Arquivos
set SVF_FILE "${DC_DIR}/design_synthesis.svf"
set MAPPED_FILE "${DC_DIR}/${NETLIST_NAME}"

# Garante que a pasta de relatorios exista
if {![file exists $RPT_PATH]} { file mkdir $RPT_PATH }

# Setup Inicial e Bibliotecas
source $FM_DIR/scripts/common_setup.tcl
set search_path "$search_path $DC_DIR"
set synopsys_auto_setup true
read_db $TARGET_LIBRARY

# Setup Verification Format
set_svf $SVF_FILE


# Abre o arquivo filelist para leitura
puts "--- Extraindo arquivos do $RTL_FILELIST ---"
set rtl_files [list]
set fp [open $RTL_FILELIST r]

while {[gets $fp line] >= 0} {
    set line [string trim $line]

    if {$line != "" && ![regexp {^#|^//} $line]} {
        if {[catch {subst $line} expanded_line]} {
            puts "WARNING: Nao foi possivel expandir: $line"
            continue
        }

        lappend rtl_files $expanded_line
    }
}

close $fp

puts "RTL files:"
foreach file $rtl_files {
    puts "  $file"
}

# Referencia
read_verilog -container r -lib WORK $rtl_files
set_top r:/WORK/${DESIGN_NAME}
report_designs


# Implementation
read_verilog -container i -lib WORK $MAPPED_FILE
set_top i:/WORK/$DESIGN_NAME

match
verify

# Geracao de Relatorios
puts "--- Gerando relatorios em $RPT_PATH ---"

# Adicionamos o nome do design no relatorio para nao sobrescrever dados
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_guidance.rpt { report_guidance -summary }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_unmatched.rpt { report_unmatched_points }
redirect -file ${RPT_PATH}/${DESIGN_NAME}_fm_failing.rpt { report_failing_points }

exit