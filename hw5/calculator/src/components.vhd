LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE top_pkg IS
COMPONENT top IS
GENERIC (
  data_width : INTEGER := 8
);
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  switch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  dout : OUT STD_LOGIC := '0'
  );
END COMPONENT top;
END PACKAGE top_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE fsm_pkg IS
COMPONENT fsm IS
GENERIC (
  data_width : INTEGER := 8
  );
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  a : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  dout : OUT STD_LOGIC := '0'
  );
END COMPONENT fsm;
END PACKAGE fsm_pkg;