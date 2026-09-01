set ANC_DIGITAL_ROOT $::env(ANC_DIGITAL_ROOT)
set DC_DIR $::env(DC_DIR)
set CONSTRAINTS_DIR $::env(CONSTRAINTS_DIR)
set RTL_DIR $::env(RTL_DIR)
set FM_DIR $::env(FM_DIR)


source "${DC_DIR}/scripts/common/setup.tcl"
source "${DC_DIR}/scripts/common/utils.tcl"

remove_design -all

define_design_lib WORK -path $work_path

foreach file {
    ANC_legacy.v
    LMS_Direct_10taps_legacy.v
} {
    puts "Analyzing $file"
    analyze -format verilog $file
}

elaborate ANC

current_design ANC

link

check_design

write_file -format verilog -hierarchy -output $DC_DIR/ANC_elaborated_legacy.v

exit