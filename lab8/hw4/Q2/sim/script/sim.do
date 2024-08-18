vlib work
vcom -93 -work work ../../src/jk_flip_flop.vhd
vcom -93 -work work ../src/jk_flip_flop_tb.vhd

vsim -voptargs=+acc jk_flip_flop_tb
do wave.do
run 700 ns
