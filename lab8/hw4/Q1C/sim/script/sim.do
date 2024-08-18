vlib work
vcom -93 -work work ../../src/d_flip_flop.vhd
vcom -93 -work work ../src/d_flip_flop_tb.vhd

vsim -voptargs=+acc d_flip_flop_tb
do wave.do
run 500 ns
