set DC_DIR $::env(DC_DIR)
set CONSTRAINTS_DIR $::env(CONSTRAINTS_DIR)
set RTL_DIR $::env(RTL_DIR)

source "${DC_DIR}/scripts/common/setup.tcl"
source "${DC_DIR}/scripts/common/utils.tcl"

check_status "READ RTL" {source "${DC_DIR}/scripts/flow/read_rtl.tcl"}

check_status "ELABORATE" {source "${DC_DIR}/scripts/flow/elaborate.tcl"}

source "${CONSTRAINTS_DIR}/constraints.sdc"
check_timing
 
check_status "SYNTHESIS" {source "${DC_DIR}/scripts/flow/synthesis.tcl"}
 
check_status "DFT" {source "${DC_DIR}/scripts/flow/dft.tcl"}
 
check_status "WRITE OUTPUTS" {source "${DC_DIR}/scripts/flow/write_outputs.tcl"}
 
check_status "REPORTS" {source "${DC_DIR}/scripts/flow/reports.tcl"}
 
puts "FINISH"

# exit