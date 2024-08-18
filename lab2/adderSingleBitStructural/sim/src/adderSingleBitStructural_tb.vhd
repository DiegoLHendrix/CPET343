--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 adderSingleBitStructural; test bench
--
--      FILE NAME:  adderSingleBitStructural_tb.vhd
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
-------------------------------------------------------------------------------

-- include ieee packages here
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- include your packages here
LIBRARY work;
USE work.adderSingleBitStructural_pkg.ALL;
USE work.alu_or_pkg.ALL;
USE work.alu_xor_pkg.ALL;
USE work.alu_and_pkg.ALL;


ENTITY adderSingleBitStructural_tb IS
END ENTITY adderSingleBitStructural_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF adderSingleBitStructural_tb IS

    ---------------------------------------------------------------------------
    -- define sigals that you will need to test UUT
    ---------------------------------------------------------------------------

    -- <define your signals here>
constant period : time := 50 ns;
signal var_a : std_logic := '0';
signal var_b : std_logic := '0';
signal cin : std_logic := '0';
signal sum : std_logic;
signal cout : std_logic;

signal input_xor2 : std_logic;
signal input_or : std_logic;

signal result_and1 : std_logic;
signal result_and2 : std_logic;

signal xor1_sig : std_logic;
signal xor2_sig : std_logic;
signal or_sig : std_logic;

    
BEGIN  -- test


    ---------------------------------------------------------------------------
    -- instantiate the unit under test (UUT)
    ---------------------------------------------------------------------------
    UUT : adderSingleBitStructural
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
		
	alu_xor_inst : alu_xor
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  result_xor1 => xor1_sig,
	  result_xor2 => xor2_sig
      );
	  
	alu_and_inst : alu_and
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  input_xor1 => xor1_sig,
	  result_and1 => result_and1,
	  result_and2 => result_and2
      );

	alu_or_inst : alu_or
    PORT MAP (
      var_a => var_a,
      var_b => var_b,
	  cin => cin,
	  input_and1 => result_and1,
	  input_and2 => result_and2,
	  result_or => or_sig
      );

    ---------------------------------------------------------------------------
    -- the process will apply the test vectors to the UUT
    ---------------------------------------------------------------------------
    stimulus : PROCESS
    BEGIN  -- PROCESS stimulus


        -- INSERT YOUR TEST VECTORS HERE
               -- Test vector 1: 0 + 0 + 0
        var_a <= '0';
        var_b <= '0';
        cin <= '0';
        wait for period;
        
        -- Test vector 2: 0 + 0 + 1
        var_a <= '0';
        var_b <= '0';
        cin <= '1';
        wait for period;
        
        -- Test vector 3: 0 + 1 + 0
        var_a <= '0';
        var_b <= '1';
        cin <= '0';
        wait for period;

        -- Test vector 4: 0 + 1 + 1
        var_a <= '0';
        var_b <= '1';
        cin <= '1';
        wait for period;

        -- Test vector 5: 1 + 0 + 0
        var_a <= '1';
        var_b <= '0';
        cin <= '0';
        wait for period;

        -- Test vector 6: 1 + 0 + 1
        var_a <= '1';
        var_b <= '0';
        cin <= '1';
        wait for period;

        -- Test vector 7: 1 + 1 + 0
        var_a <= '1';
        var_b <= '1';
        cin <= '0';
        wait for period;

        -- Test vector 8: 1 + 1 + 1
        var_a <= '1';
        var_b <= '1';
        cin <= '1';
        -- wait for period;


        -----------------------------------------------------------------------
        -- stop simulation, wait here forever
        -----------------------------------------------------------------------
        wait;
    END PROCESS stimulus;

END ARCHITECTURE test;

-------------------------------------------------------------------------------
