-------------------------------------------------------------------------------
-- Dieg Lopez
-- D Flip Flop
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

PACKAGE dff_pkg IS
COMPONENT d_flip_flop is port ( data, clk, reset : in std_logic;
  not_que,que : out std_logic );
END COMPONENT d_flip_flop;
END PACKAGE dff_pkg;

library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop is port ( data, clk, reset : in std_logic;
  not_que,que : out std_logic );
end d_flip_flop;

architecture example of d_flip_flop is
begin
  process (clk)
  begin
    if (FALLING_EDGE(clk)) then 
      que <= data;
      not_que <= not data;
      END IF;
    IF (reset = '0') THEN
      que <= '0';
      not_que <= '1';
    END IF;
  end process;
end example;