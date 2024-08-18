-------------------------------------------------------------------------------
-- Diego Lopez
-- switch led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity switch is
  generic (
    max_count       : integer := 25000000
  );
  port (
    reset           : in  std_logic;
	input 			: in std_logic;
    output          : out std_logic
  );  
end switch;  

architecture beh of switch  is

signal count_sig    : integer range 0 to max_count := 0;
signal output_sig   : std_logic;

begin
process(reset,input)
  begin
    if (input = '0') then 
      count_sig <= 0;
      output_sig <= '0';
    elsif (input = '1') then
	output_sig <= not output_sig;
      if (count_sig = max_count) then
        count_sig <= 0;
      else
        count_sig <= count_sig + 1;
      end if; 
    end if;
  end process;
  
  output <= output_sig;
end beh;