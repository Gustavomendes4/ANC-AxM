##########################################################################################
# User-defined variables for logical library setup in dc_setup.tcl
##########################################################################################
set PDK_BASE "/pdk/synopsys/saed32/SAED32_EDK"

set TARGET_LIBRARY "${PDK_BASE}/lib/stdcell_hvt/db_nldm/saed32hvt_tt1p05v25c.db"

set NDM_DESIGN_LIB "ANC.dlib";

set NDM_REFERENCE_LIB_DIRS " \
	${PDK_BASE}/lib/stdcell_hvt/ndm/saed32hvt_base_frame_timing.ndm \
	${PDK_BASE}/lib/stdcell_hvt/ndm/saed32hvt_pg_frame_timing.ndm \
"

set TECH_FILE "${PDK_BASE}/tech/tf/saed32nm_1p9m.tf"

set TLUPLUS_MAX_FILE "${PDK_BASE}/tech/starrc/nominal/saed32nm_1p9m_nominal.tluplus"
set TLUPLUS_MIN_FILE "${PDK_BASE}/tech/starrc/nominal/saed32nm_1p9m_nominal.tluplus"

set MAP_FILE  "${PDK_BASE}/tech/starrc/saed32nm_tf_itf_tluplus.map"


# #Bedin ↓

# set ADDITIONAL_SEARCH_PATH  [join "
#          ../../../../../ref/DBs
#          ../../../../../ref/CLIBs
#          ../../../../../ref/tech
#         "]  ;#  Directories containing logic libraries, logic design, physical libraries
#              #  technology files and script files.
# #saed32hvt_ss0p75v125c.db
# set TARGET_LIBRARY_FILES    [join "
#          saed32lvt_ss0p75v125c.db
#         "]  ;#  Logic cell library files

# ##########################################################################################
# # User-defined variables for physical library setup in dc_setup.tcl
# ##########################################################################################

# set NDM_DESIGN_LIB "TOP.dlib" ;#  User-defined NDM design library name
# #saed32_hvt.ndm
# set NDM_REFERENCE_LIBS      [join "
#          saed32_lvt.ndm
#         "] ;#  physical cell libraries

# set TECH_FILE                "saed32nm_1p9m.tf"              ;#  Technology file

# set TLUPLUS_MAX_FILE         "saed32nm_1p9m_Cmax.tluplus"    ;#  Max TLUPlus file

# set MAP_FILE                 "saed32nm_tf_itf_tluplus.map"   ;#  Mapping file for TLUplus

# return
