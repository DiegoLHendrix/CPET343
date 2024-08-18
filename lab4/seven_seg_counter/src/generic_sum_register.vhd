LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE generic_sum_register_pkg IS
  COMPONENT generic_sum_register IS
    PORT (
	  sum : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
	  clk : IN  STD_LOGIC;
	  enable : IN  STD_LOGIC;
	  sum_sig : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT generic_sum_register;
END PACKAGE generic_sum_register_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY generic_sum_register IS
    PORT (
	  sum : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
	  clk : IN  STD_LOGIC;
	  enable : IN  STD_LOGIC;
	  sum_sig : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY generic_sum_register;

ARCHITECTURE Behavioral OF generic_sum_register IS
SIGNAL output : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
  PROCESS(clk,enable)
  BEGIN
    IF rising_edge(clk) THEN
	  IF enable = '1' THEN
	    output <= sum;
	  END IF;
    END IF;
  END PROCESS;
  sum_sig <= output;
END ARCHITECTURE Behavioral;
