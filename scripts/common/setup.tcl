source "${ROOT_DIR}/scripts/pdks/saed32/multi_vt.tcl"

set LIBRARY_FILES "${NDM_REFERENCE_LIB_DIRS}"
lappend search_path "${DB_PATH}"

#PATH FIX: Assuming that the RTL is in the root directory of the project
lappend search_path "${ROOT_DIR}/rtl"

set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $synthetic_library"