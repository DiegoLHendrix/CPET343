-------------------------------------------------------------------------------
-- Diego Lopez
-- switch test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity switch_tb is
end switch_tb;

architecture arch of switch_tb is

component switch is
  generic (
    max_count       : integer := 25000000
  );
  port (
    reset           : in  std_logic;
	input 			: in std_logic;
    output          : out std_logic
  );  
end component;  

signal output       : std_logic;
constant period     : time := 20 ns;
signal reset        : std_logic := '1';
signal input 		: std_logic := '0';

begin 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
   wait;
end process;

-- input process
switch_proc: process
  begin
	input <= not input;
    wait for period/2;
end process; 

uut: switch  
  generic map (
    max_count => 4
  )
  port map(
    reset     => reset,
	input     => input,
    output    => output
  );
end arch;