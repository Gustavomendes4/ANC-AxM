#####################################################################
# PDK SETUP
source "${DC_DIR}/scripts/pdks/saed32/hvt.tcl"

set LIBRARY_FILES "${NDM_REFERENCE_LIB_DIRS}"
lappend search_path "${DB_PATH}"

#PATH FIX: Assuming that the RTL is in the root directory of the project
lappend search_path "${RTL_DIR}"

lappend search_path "${target_library}"

set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $synthetic_library"
set ndm_design_library "$NDM_DESIGN_LIB"

###### TESTE
if {![file isdirectory "${ndm_design_library}"]} {

    puts "Creating NDM design library..."

    create_lib \
        -technology "${TECH_FILE}" \
        -ref_libs "${NDM_REFERENCE_LIB_DIRS}" \
        "${ndm_design_library}"

} else {

    puts "Opening existing NDM design library..."

    open_lib "${ndm_design_library}"

    set_ref_libs \
        -ref_libs "${NDM_REFERENCE_LIB_DIRS}"
}


#####################################################################
# PATH SETUP
set RUN_NAME [clock format [clock seconds] -format "%Y%m%d_%H%M%S"]

set RUN_DIR "${DC_DIR}/runs/$RUN_NAME"

set REPORTS_DIR  "$RUN_DIR/reports"
set OUTPUTS_DIR  "$RUN_DIR/outputs"
set WORK_DIR  "$RUN_DIR/work"
set SNAPSHOT_DIR "$RUN_DIR/snapshots"
set FORMALITY_DIR "$RUN_DIR/formality"


foreach dir [list $RUN_DIR $REPORTS_DIR $OUTPUTS_DIR $SNAPSHOT_DIR $FORMALITY_DIR] {
    file mkdir $dir
    puts "Criado: $dir"
}

set work_path "$WORK_DIR"

if {![file exists $work_path]} {
    file mkdir $work_path
}

set files_to_backup {
    rtl
    scripts
}

foreach file $files_to_backup {
    set src "${DC_DIR}/${file}"
    if {[file exists $src]} {
        file copy -force $src $SNAPSHOT_DIR/
    } else {
        puts "WARNING: Arquivo nao encontrado: $src"
    }
}

puts ""
puts "RUN NAME: $RUN_NAME"
puts "RUN DIR: $RUN_DIR"
puts "REPORTS: $REPORTS_DIR"
puts "OUTPUTS: $OUTPUTS_DIR"
puts "SNAPSHOTS: $SNAPSHOT_DIR"
puts ""

