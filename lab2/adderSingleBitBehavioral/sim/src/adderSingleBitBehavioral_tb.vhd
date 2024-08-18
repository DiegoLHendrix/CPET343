--*****************************************************************************
--***************************  VHDL Source Code  ******************************
--*****************************************************************************
--
--  DESIGNER NAME:  Diego Lopez
--
--       LAB NAME:  Lab 2 adderSingleBitBehavioral; test bench
--
--      FILE NAME:  adderSingleBitBehavioral_tb.vhd
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
USE work.adderSingleBitBehavioral_pkg.ALL;


ENTITY adderSingleBitBehavioral_tb IS
END ENTITY adderSingleBitBehavioral_tb;

-------------------------------------------------------------------------------

ARCHITECTURE test OF adderSingleBitBehavioral_tb IS

    ---------------------------------------------------------------------------
    -- define sigals that you will need to test UUT
    ---------------------------------------------------------------------------

    -- <define your signals here>
constant period : time := 50 ns;
signal var_a : std_logic := '0';
signal var_b : std_logic := '0';
signal cin : std_logic := '0';
signal sum : std_logic := '0';
signal cout : std_logic := '0';
    
BEGIN  -- test


    ---------------------------------------------------------------------------
    -- instantiate the unit under test (UUT)
    ---------------------------------------------------------------------------
    UUT : adderSingleBitBehavioral
    PORT MAP (
        
        -- <connect UUT I/O to testbench signals>
        -- <format: component signal => tb signal>
		var_a => var_a,
		var_b => var_b,
		cin => cin,
		sum => sum,
		cout => cout
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
