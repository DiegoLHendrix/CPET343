vlib work
vcom -93 -work work ../../src/components.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../../src/fsm.vhd
vcom -93 -work work ../src/hw_tb.vhd

vsim -voptargs=+acc hw_tb
do wave.do
run 500 ns
