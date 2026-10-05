remove_design -all

define_design_lib WORK -path $work_path

foreach file {
    ANC.v
    LMS_Direct_10taps.v
} {
    puts "Analyzing $file"
    analyze -format verilog $file
}