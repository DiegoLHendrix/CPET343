# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "generic_adder_arch"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY generic_adder_arch
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/generic_adder_arch.vhd
set_global_assignment -name VHDL_FILE ../../src/full_adder_single_bit_arch/src/alu_and.vhd
set_global_assignment -name VHDL_FILE ../../src/full_adder_single_bit_arch/src/alu_or.vhd
set_global_assignment -name VHDL_FILE ../../src/full_adder_single_bit_arch/src/alu_xor.vhd
set_global_assignment -name VHDL_FILE ../../src/full_adder_single_bit_arch/src/full_adder_single_bit_arch.vhd
execute_flow -compile
project_close