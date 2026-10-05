// ==============================================================================
// Arquivo: verif/filelist.f
// Caminhos relativos ao diretório de compilação: tools/vcs/scripts/
// Variaveis de ambiente definidas em setup.sh
// ==============================================================================


// Diretórios de Inclusão (Include directories)
+incdir+$RTL_DIR
+incdir+$VERIF_DIR

//verif
$VERIF_DIR/tb_ANC.v
//SystemVerilog ex:
//$VERIF_DIR/top_tb_gl.sv

// Netlist sintetizado (RTL-GL)
$DC_DIR/outputs_latest/top_syn.v

// Arquivos de Design (RTL-GL)
// Substituidos pelo netlist sintetizado(Testar funcionalidade antes de excluir)
//../../../../../ref/verilog/saed32nm_lvt.v
//../../dc_nxt/outputs/top_cpu_mapped.v





