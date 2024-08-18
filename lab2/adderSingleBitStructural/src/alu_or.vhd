--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 alu_or
--
--      FILE NAME:  alu_or
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
USE work.alu_and_pkg.ALL;

PACKAGE alu_or_pkg IS
  COMPONENT alu_or IS
    PORT (
      var_a    : IN  std_logic;
      var_b    : IN  std_logic;
      cin    : IN  std_logic;
	  input_and1 : IN std_logic;
	  input_and2 : IN std_logic;
	  result_or    : OUT  std_logic
      );
  END COMPONENT;
END PACKAGE alu_or_pkg;



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
USE work.alu_and_pkg.ALL;

ENTITY alu_or  IS
  PORT (
    var_a    : IN std_logic;
	var_b    : IN  std_logic;
	cin    : IN  std_logic;
	input_and1 : IN std_logic;
	input_and2 : IN std_logic;
	result_or : OUT std_logic
    );
END ENTITY alu_or ;

ARCHITECTURE behave OF alu_or  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------

BEGIN
	process(var_a,var_b,cin,input_and1,input_and2)
	BEGIN
		result_or <= input_and1 or input_and2;
	END process;
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
