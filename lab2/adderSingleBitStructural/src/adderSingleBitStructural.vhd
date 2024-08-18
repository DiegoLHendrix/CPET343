--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 adderSingleBitStructural
--
--      FILE NAME:  adderSingleBitStructural
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

PACKAGE adderSingleBitStructural_pkg IS
  COMPONENT adderSingleBitStructural IS
    PORT (
      var_a : IN  std_logic;
      var_b : IN  std_logic;
      cin : IN  std_logic;
	  input_xor2 : IN std_logic;
	  input_or : IN std_logic;
      -- add any inputs here
      --
      -- add any outputs here
	  sum    : OUT  std_logic;
	  cout    : OUT  std_logic
      );
  END COMPONENT;
END PACKAGE adderSingleBitStructural_pkg;



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

ENTITY adderSingleBitStructural  IS
  PORT (
    var_a : IN std_logic;
	var_b : IN  std_logic;
	cin : IN  std_logic;
	input_xor2 : IN std_logic;
	input_or : IN std_logic;
    -- add any inputs here
    --
    -- add any outputs here
	sum : OUT std_logic;
	cout : OUT std_logic
    );
END ENTITY adderSingleBitStructural ;

ARCHITECTURE behave OF adderSingleBitStructural  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------

BEGIN
	process(var_a,var_b,cin,input_xor2,input_or)
	BEGIN
		sum <= input_xor2;
		cout <= input_or;
	END process;
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
