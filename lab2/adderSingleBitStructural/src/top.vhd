--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab2: adderSingleBitStructural
--
--      FILE NAME:  top.vhd
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--    This file is a used for compiling file in Quartus so the ENTITY 
--    signals names match the DE1-SOC board pins file names. 
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 08/01/20 | xxx  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.adderSingleBitStructural_pkg.ALL;
USE work.alu_or_pkg.ALL;
USE work.alu_xor_pkg.ALL;
USE work.alu_and_pkg.ALL;

ENTITY top IS
  PORT (
    var_a : IN std_logic;
    var_b : IN std_logic;
    cin : IN std_logic;
	
	sum : OUT std_logic;
	cout : OUT std_logic;
	result_or : OUT std_logic;
	result_xor1 : OUT  std_logic;
	result_xor2 : OUT  std_logic;
	result_and1 : OUT  std_logic;
	result_and2 : OUT  std_logic
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

signal or_sig : std_logic;
signal xor1_sig : std_logic;
signal xor2_sig : std_logic;
signal and1_sig : std_logic;
signal and2_sig : std_logic;

BEGIN

  top_inst : adderSingleBitStructural
    PORT MAP (
	-- <format: package component signal => top signal>
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  sum => sum,
	  input_xor2 => xor2_sig,
	  input_or => or_sig,
	  cout => cout
      );
	  
top_inst_xor : alu_xor
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  result_xor1 => xor1_sig,
	  result_xor2 => xor2_sig
      );
	  
top_inst_and : alu_and
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  input_xor1 => xor1_sig,
	  result_and1 => result_and1,
	  result_and2 => result_and2
      );

top_inst_or : alu_or
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  input_and1 => and1_sig,
	  input_and2 => and2_sig,
	  result_or => result_or
      );
	  
END ARCHITECTURE arch;
