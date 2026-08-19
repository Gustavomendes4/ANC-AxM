# tools/modelsim/scripts/wave.do
# Loaded automatically in GUI mode (make sim GUI=1)
# waveform view 

add wave -divider "Clock/Reset"
add wave -radix binary /tb_ANC/clock
add wave -radix binary /tb_ANC/reset

add wave -divider "DUT I/O"
add wave -radix hex /tb_ANC/x_in
add wave -radix hex /tb_ANC/dn
add wave -radix hex /tb_ANC/mi
add wave -radix hex /tb_ANC/en
add wave -radix hex /tb_ANC/out

add wave -divider "Testbench State"
add wave -radix decimal /tb_ANC/count

configure wave -namecolwidth 200
configure wave -valuecolwidth 100
wave zoom full
