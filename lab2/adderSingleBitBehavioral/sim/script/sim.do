vlib work
vcom -93 -quiet -work work ../../src/adderSingleBitBehavioral.vhd
vcom -93 -quiet -work work ../src/adderSingleBitBehavioral_tb.vhd
vsim -voptargs=+acc adderSingleBitBehavioral_tb
do wave.do
run 500 ns
