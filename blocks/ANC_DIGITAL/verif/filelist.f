// ==============================================================================
// Arquivo: verif/filelist.f
// Variaveis de ambiente definidas em setup.sh
// ==============================================================================

//TODO: arrumar isso para usar alguma variável de ambiente, de modo que isso não fique com esse tanto de "ponto ponto"

// 1. Diretórios de Inclusão (Include directories)
+incdir+$RTL_DIR
+incdir+$VERIF_DIR

// 2. Arquivos de Verificação (Testbench)
$VERIF_DIR/tb_ANC.v

//SystemVerilog ex:
//../../../verif/top_tb.sv


// 3. Arquivos de Design (RTL)
$RTL_DIR/ANC.v
$RTL_DIR/LMS_Direct_10taps.v

//SystemVerilog ex:
//../../../rtl/Memory.sv
//../../../rtl/CPU.sv
//../../../rtl/top_cpu.sv


