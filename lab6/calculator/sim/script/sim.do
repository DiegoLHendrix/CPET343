vlib work
vcom -93 -work work ../../src/components.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../../src/fsm.vhd
vcom -93 -work work ../../src/clock_synchronizer.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/generic_adder_beh.vhd
vcom -93 -work work ../../src/generic_subtractor_beh.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../src/seven_seg_tb.vhd

vsim -voptargs=+acc seven_seg_tb
do wave.do
run 700 ns
