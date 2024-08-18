-------------------------------------------------------------------------------
-- Dieg Lopez
-- D Flip Flop
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

PACKAGE dff_pkg IS
COMPONENT d_flip_flop is port ( data, clk : in std_logic;
  que : out std_logic );
END COMPONENT d_flip_flop;
END PACKAGE dff_pkg;

library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is port ( data, clk : in std_logic;
  que : out std_logic );
end d_flip_flop;

architecture example of d_flip_flop is
begin
  process (clk)
  begin
    if (rising_edge(clk)) then 
      que <= data;
    end if;
  end process;
end example;