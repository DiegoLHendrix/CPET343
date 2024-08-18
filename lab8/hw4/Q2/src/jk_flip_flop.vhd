-------------------------------------------------------------------------------
-- Dieg Lopez
-- JK Flip Flop
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE jkff_pkg IS
COMPONENT jk_flip_flop IS PORT ( 
  clk, clear, preset : IN std_logic;
  j, k : IN std_logic;
  q, qn: OUT std_logic 
  );
END COMPONENT jk_flip_flop;
END PACKAGE jkff_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY jk_flip_flop IS PORT ( 
  clk, clear, preset : IN std_logic;
  j, k : IN std_logic;
  q, qn: OUT std_logic 
  );
END jk_flip_flop;

architecture example of jk_flip_flop is
  SIGNAL q_sig : STD_LOGIC := '0';
  SIGNAL temp : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');

begin
  temp <= j & k;
  process (clk)
  begin
    IF (RISING_EDGE(clk)) THEN
      IF (clear = '0') THEN
        q_sig <= '0';

      ELSIF (preset = '0') THEN
        q_sig <= '1';

      ELSE
        CASE (temp) IS
          WHEN "00" =>
            q_sig <= q_sig;

          WHEN "01" => 
            q_sig <= '0';

          WHEN "10" => 
            q_sig <= '1';

          WHEN "11" => 
            q_sig <= not q_sig;
            
          WHEN OTHERS =>
            q_sig <= '0';
            END CASE;

        END IF;
      END IF;
  end process;
  
q <= q_sig;
qn <= not q_sig;
end example;