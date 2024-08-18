--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab2: adderSingleBitBehavioral
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
USE work.adderSingleBitBehavioral_pkg.ALL;

ENTITY top IS
  PORT (
    var_a : IN std_logic;
    var_b : IN std_logic;
    cin : IN std_logic;
	sum : OUT std_logic;
	cout : OUT std_logic
    );
END ENTITY top;

ARCHITECTURE arch OF top IS

BEGIN

  top_inst : adderSingleBitBehavioral
    PORT MAP (
	-- <format: package component signal => top signal>
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  sum => sum,
	  cout => cout
      );


END ARCHITECTURE arch;
