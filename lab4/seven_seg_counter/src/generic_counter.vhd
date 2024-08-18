-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

PACKAGE generic_counter_pkg IS
	component generic_counter is
	  generic (
		max       : integer := 3
	  );
	  port (
		clk             : in  std_logic; 
		reset           : in  std_logic;
		output          : out std_logic
	  );  
	end component;
END PACKAGE generic_counter_pkg;

library ieee;
use ieee.std_logic_1164.all;      

entity generic_counter is
  generic (
    max       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end generic_counter;  

architecture beh of generic_counter  is

signal count_sig    : integer range 0 to max := 0;

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      count_sig <= 0;
      output <= '0';
    elsif (clk'event and clk = '1') then
      if (count_sig = max) then
        count_sig <= 0;
        output <= '1';
      else
        count_sig <= count_sig + 1;
        output <= '0';
      end if; 
    end if;
  end process;
end beh;