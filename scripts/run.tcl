#Anchoring paths to directory root/Avoid moving up and down directories
set ROOT_DIR [file dirname [file dirname [file normalize [info script]]]]

#Note que para rodar esse comando (recomendado) estar dentro de uma pasta na mesma altura que scripts

source "${ROOT_DIR}/scripts/common/setup.tcl"
source "${ROOT_DIR}/scripts/common/utils.tcl"
source "${ROOT_DIR}/scripts/common/create_run_dirs.tcl"

check_status "READ RTL" {source "${ROOT_DIR}/scripts/flow/read_rtl.tcl"}

check_status "ELABORATE" {source "${ROOT_DIR}/scripts/flow/elaborate.tcl"}

source "${ROOT_DIR}/scripts/constraints/cons.tcl"
check_timing
 
check_status "SYNTHESIS" {source "${ROOT_DIR}/scripts/flow/synthesis.tcl"}
 
check_status "DFT" {source "${ROOT_DIR}/scripts/flow/dft.tcl"}
 
check_status "WRITE OUTPUTS" {source "${ROOT_DIR}/scripts/flow/write_outputs.tcl"}
 
check_status "REPORTS" {source "${ROOT_DIR}/scripts/flow/reports.tcl"}
 
puts "FINISH"

# exit