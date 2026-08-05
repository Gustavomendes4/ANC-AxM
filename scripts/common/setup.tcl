source ../scripts/pdks/saed32/multi_vt.tcl

set LIBRARY_FILES "${NDM_REFERENCE_LIB_DIRS}"
lappend search_path "${DB_PATH}"

# TODO: pensar em como colocar isso em uma variável que de para todos usar
lappend search_path "/home/ciexpert/vinicius.miguel/development/ANC-AxM-clean/rtl"

set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $synthetic_library"

[]