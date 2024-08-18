--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 adderSingleBitBehavioral
--
--      FILE NAME:  adderSingleBitBehavioral
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

PACKAGE adderSingleBitBehavioral_pkg IS
  COMPONENT adderSingleBitBehavioral IS
    PORT (
      var_a    : IN  std_logic;
      var_b    : IN  std_logic;
      cin    : IN  std_logic;
      -- add any inputs here
      --
      -- add any outputs here
	  sum    : OUT  std_logic;
	  cout    : OUT  std_logic
      );
  END COMPONENT;
END PACKAGE adderSingleBitBehavioral_pkg;



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
USE work.adderSingleBitBehavioral_pkg.ALL;

ENTITY adderSingleBitBehavioral  IS
  PORT (
    var_a    : IN std_logic;
	var_b    : IN  std_logic;
	cin    : IN  std_logic;
    -- add any inputs here
    --
    -- add any outputs here
	sum : OUT std_logic;
	cout : OUT std_logic
    );
END ENTITY adderSingleBitBehavioral ;

ARCHITECTURE behave OF adderSingleBitBehavioral  IS

    ---------------------------------------------------------------------------
    -- define your signals here
    -- format: signal abc : <type>;
    ---------------------------------------------------------------------------

BEGIN
	process(var_a,var_b,cin)
	BEGIN
		sum <= var_a xor var_b xor cin;
		cout <= (var_a and var_b) or (var_b and cin) or ( var_a and cin);
	END process;
    ---------------------------------------------------------------------------
    -- define your equations/design here
    ---------------------------------------------------------------------------

END ARCHITECTURE behave;
