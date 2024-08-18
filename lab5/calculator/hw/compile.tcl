# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "calculator"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files
set_global_assignment -name NUM_PARALLEL_PROCESSORS 4

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/top.vhd
set_global_assignment -name VHDL_FILE ../../src/components.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/clock_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg_top.vhd
set_global_assignment -name VHDL_FILE ../../src/adder_beh.vhd
set_global_assignment -name VHDL_FILE ../../src/subtractor_beh.vhd

set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AA15 -to add_async
set_location_assignment PIN_W15  -to subtractor_async
# set_location_assignment PIN_Y16  -to execute

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to add_async
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to subtractor_async
# set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to execute

# set_location_assignment PIN_V16  -to led[0]
# set_location_assignment PIN_W16  -to led[1]
# set_location_assignment PIN_V17  -to led[2]
# set_location_assignment PIN_V18  -to led[3]
# set_location_assignment PIN_W17  -to led[3]

set_location_assignment PIN_AB12 -to reset
# set_location_assignment PIN_AC12 -to switch[1]
set_location_assignment PIN_AF9  -to input_2_async[0]
set_location_assignment PIN_AF10 -to input_2_async[1]
set_location_assignment PIN_AD11 -to input_2_async[2]

set_location_assignment PIN_AD12 -to input_1_async[0]
set_location_assignment PIN_AE11 -to input_1_async[1]
set_location_assignment PIN_AC9  -to input_1_async[2]

# set_location_assignment PIN_AD10 -to op[0]
# set_location_assignment PIN_AE12 -to op[1]

set_location_assignment PIN_AE26 -to HEX0[0]
set_location_assignment PIN_AE27 -to HEX0[1]
set_location_assignment PIN_AE28 -to HEX0[2]
set_location_assignment PIN_AG27 -to HEX0[3]
set_location_assignment PIN_AF28 -to HEX0[4]
set_location_assignment PIN_AG28 -to HEX0[5]
set_location_assignment PIN_AH28 -to HEX0[6]

set_location_assignment PIN_AB23 -to HEX2[0]
set_location_assignment PIN_AE29 -to HEX2[1]
set_location_assignment PIN_AD29 -to HEX2[2]
set_location_assignment PIN_AC28 -to HEX2[3]
set_location_assignment PIN_AD30 -to HEX2[4]
set_location_assignment PIN_AC29 -to HEX2[5]
set_location_assignment PIN_AC30 -to HEX2[6]

set_location_assignment PIN_AA24 -to HEX4[0]
set_location_assignment PIN_Y23 -to HEX4[1]
set_location_assignment PIN_Y24 -to HEX4[2]
set_location_assignment PIN_W22 -to HEX4[3]
set_location_assignment PIN_W24 -to HEX4[4]
set_location_assignment PIN_V23 -to HEX4[5]
set_location_assignment PIN_W25 -to HEX4[6]

# set_location_assignment PIN_AD26 -to bcd_3[0]
# set_location_assignment PIN_AC27 -to bcd_3[1]
# set_location_assignment PIN_AD25 -to bcd_3[2]
# set_location_assignment PIN_AC25 -to bcd_3[3]
# set_location_assignment PIN_AB28 -to bcd_3[4]
# set_location_assignment PIN_AB25 -to bcd_3[5]
# set_location_assignment PIN_AB22 -to bcd_3[6]

# set_location_assignment PIN_AA24 -to bcd_4[0]
# set_location_assignment PIN_Y23  -to bcd_4[1]
# set_location_assignment PIN_Y24  -to bcd_4[2]
# set_location_assignment PIN_W22  -to bcd_4[3]
# set_location_assignment PIN_W24  -to bcd_4[4]
# set_location_assignment PIN_V23  -to bcd_4[5]
# set_location_assignment PIN_W25  -to bcd_4[6]

# set_location_assignment PIN_V25  -to bcd_5[0]
# set_location_assignment PIN_AA28 -to bcd_5[1]
# set_location_assignment PIN_Y27  -to bcd_5[2]
# set_location_assignment PIN_AB27 -to bcd_5[3]
# set_location_assignment PIN_AB26 -to bcd_5[4]
# set_location_assignment PIN_AA26 -to bcd_5[5]
# set_location_assignment PIN_AA25 -to bcd_5[6]

execute_flow -compile
project_close