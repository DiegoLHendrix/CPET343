LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE top_pkg IS
COMPONENT top IS
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC := '0';
  button_async : IN STD_LOGIC;
  switch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  bcd_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  bcd_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  bcd_2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END COMPONENT top;
END PACKAGE top_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE fsm_pkg IS
COMPONENT fsm IS
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC := '0';
  button_sync : IN STD_LOGIC := '0';
  switch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  sum : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
  difference : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
  a : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
  b : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  HEX : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END COMPONENT fsm;
END PACKAGE fsm_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE seven_seg_pkg IS
COMPONENT seven_seg IS
PORT (
  bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );  
END COMPONENT seven_seg;
END PACKAGE seven_seg_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE rising_edge_pkg IS
COMPONENT rising_edge_synchronizer IS 
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  input : IN STD_LOGIC;
  edge : OUT STD_LOGIC
  );
END COMPONENT rising_edge_synchronizer;
END PACKAGE rising_edge_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE clock_synchronizer_pkg IS
COMPONENT clock_synchronizer IS
GENERIC (
  bit_width : integer := 3
  );
PORT (
  clk      : IN  std_logic;
  reset    : IN  std_logic;
  async_in : IN  std_logic_vector(bit_width-1 DOWNTO 0);
  sync_out : OUT std_logic_vector(bit_width-1 DOWNTO 0)
  );
END COMPONENT clock_synchronizer;
END PACKAGE clock_synchronizer_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE generic_adder_pkg IS
COMPONENT generic_adder_beh IS
GENERIC (
  bits    : INTEGER := 4
  );
PORT (
  a : IN STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
  b : IN STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
  cin : IN STD_LOGIC;
  sum : OUT STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
  cout : OUT STD_LOGIC
  );
END COMPONENT generic_adder_beh;
END PACKAGE generic_adder_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE generic_subtractor_pkg IS
COMPONENT generic_subtractor_beh IS
GENERIC (
  bits    : INTEGER := 4
  );
PORT (
  a       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
  b       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
  cin     : IN  STD_LOGIC;
  difference     : OUT STD_LOGIC_VECTOR(bits-1 DOWNTO 0) := (OTHERS => '0');
  cout    : OUT STD_LOGIC
  );
END COMPONENT generic_subtractor_beh;
END PACKAGE generic_subtractor_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE double_dabble_pkg IS
COMPONENT double_dabble IS
PORT (
  result_padded : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
  ones : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  tens : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  hundreds : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT double_dabble;
END PACKAGE double_dabble_pkg;
