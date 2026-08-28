// ==============================================================================
// verif/filelist_uvm.f - UVM testbench for the ANC driver
// Environment variables defined in setup.sh
//
// Usage:  make sim UVM=1 UVM_TEST=<test_name>
//
// anc_transaction.sv and anc_sequencer.sv are NOT listed here: they are
// `include'd by anc_pkg.sv, resolved through the +incdir+$VERIF_DIR below.
// Listing them in both places would declare the classes twice.
// ==============================================================================

// 1. Include directories
+incdir+$RTL_DIR
+incdir+$VERIF_DIR
+incdir+$VERIF_DIR/uvm
+incdir+$VERIF_DIR/uvm/components

// 2. UVM testbench - order matters: interface -> package -> top
$VERIF_DIR/uvm/anc_if.sv
$VERIF_DIR/uvm/anc_pkg.sv
$VERIF_DIR/uvm/tb_top.sv

// 3. Design files (RTL)
$RTL_DIR/ANC.v
$RTL_DIR/LMS_Direct_10taps.v
