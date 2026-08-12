// ==============================================================================
// Arquivo: verif/filelist.f
// Caminhos relativos ao diretório de compilação: tools/vcs/scripts/
// ==============================================================================

//TODO: arrumar isso para usar alguma variável de ambiente, de modo que isso não fique com esse tanto de "ponto ponto"

// 1. Diretórios de Inclusão (Include directories)
+incdir+../../../rtl
+incdir+../../../verif

// 3. Arquivos de Verificação (Testbench)
../../../verif/top_tb.sv

// 2. Arquivos de Design (RTL)
../../../rtl/Memory.sv
../../../rtl/CPU.sv
../../../rtl/top_cpu.sv


