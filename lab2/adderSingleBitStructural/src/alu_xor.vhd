--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 alu_xor
--
--      FILE NAME:  alu_xor
--
-------------------------------------------------------------------------------
--
--  DESCRIPTION
--
--    This design will <insert detailed description of design>. 
--
--
-------------------------------------------------------------------------------
--
--  REVISION HISTORY
--
--  _______________________________________________________________________
-- |  DATE    | USER | Ver |  Description                                  |
-- |==========+======+=====+================================================
-- |          |      |     |
-- | 08/23/20 | XXX  | 1.0 | Created
-- |          |      |     |
--
--*****************************************************************************
--*****************************************************************************

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||||                                                                   ||||
-- ||||                    COMPONENT PACKAGE                              ||||
-- ||||                                                                   ||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.adderSingleBitStructural_pkg.ALL;

PACKAGE alu_xor_pkg IS
  COMPONENT alu_xor IS
    PORT (
      var_a    : IN  std_logic;
      var_b    : IN  std_logic;
      cin    : IN  std_logic;
	  result_xor1 : OUT  std_logic;
	  result_xor2 : OUT  std_logic
      );
  END COMPONENT;
END PACKAGE alu_xor_pkg;

------------------------------------------------------------------------------
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||| 
-- |||| COMPONENT DESCRIPTION 
-- |||| 
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.adderSingleBitStructural_pkg.ALL;

ENTITY alu_xor  IS
  PORT (
    var_a    : IN std_logic;
	var_b    : IN  std_logic;
	cin    : IN  std_logic;
	result_xor1 : OUT  std_logic;
	result_xor2 : OUT  std_logic
    );
END ENTITY alu_xor ;

ARCHITECTURE behave OF alu_xor  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------

BEGIN
	process(var_a,var_b,cin)
	BEGIN
		result_xor1 <= var_a xor var_b;
		result_xor2 <= var_a xor var_b xor cin;
	END process;
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
