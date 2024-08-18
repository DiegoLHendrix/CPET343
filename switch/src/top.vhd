-------------------------------------------------------------------------------
-- Diego Lopez
-- switch top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    reset           : in  std_logic;
	input 			: in std_logic;
    output          : out std_logic
  );
end top;

architecture beh of top is

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

begin

uut: switch  
  generic map (
    max_count => 50000000
  )
  port map(
    reset     => reset,
	input     => input,
    output    => output
  );
end beh;