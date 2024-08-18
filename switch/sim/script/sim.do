vlib work
vcom -93 -work work ../../src/switch.vhd
vcom -93 -work work ../src/switch_tb.vhd
vsim -voptargs=+acc switch_tb
do wave.do
run 500 ns
