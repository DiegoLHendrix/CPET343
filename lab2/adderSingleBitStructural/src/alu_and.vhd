--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 alu_and
--
--      FILE NAME:  alu_and
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
USE work.alu_xor_pkg.ALL;

PACKAGE alu_and_pkg IS
  COMPONENT alu_and IS
    PORT (
      var_a    : IN  std_logic;
      var_b    : IN  std_logic;
      cin    : IN  std_logic;
	  input_xor1 : IN std_logic;
	  result_and1    : OUT  std_logic;
	  result_and2    : OUT  std_logic
      );
  END COMPONENT;
END PACKAGE alu_and_pkg;



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
USE work.alu_xor_pkg.ALL;

ENTITY alu_and  IS
  PORT (
    var_a    : IN std_logic;
	var_b    : IN  std_logic;
	cin    : IN  std_logic;
	input_xor1 : IN std_logic;
	result_and1    : OUT  std_logic;
	result_and2    : OUT  std_logic
    );
END ENTITY alu_and ;

ARCHITECTURE behave OF alu_and  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------
BEGIN
	process(var_a,var_b,cin,input_xor1)
	BEGIN
	result_and1 <= var_a and var_b;
	result_and2 <= input_xor1 and cin;
	END process;
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
