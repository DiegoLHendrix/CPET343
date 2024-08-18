LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE top_pkg IS
COMPONENT top IS
GENERIC (
  addr_width : INTEGER := 2;
  data_width : INTEGER := 8
  );
PORT (
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC;
  mr : IN STD_LOGIC;
  ms : IN STD_LOGIC;
  execute : IN STD_LOGIC;
  op : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  switch : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
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
GENERIC (
  addr_width : INTEGER := 2;
  data_width : INTEGER := 8
  );
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  mr : IN STD_LOGIC;
  ms : IN STD_LOGIC;
  execute : IN STD_LOGIC;
  a : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  b : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  we : OUT STD_LOGIC := '1';
  addr : OUT STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0) := (OTHERS => '0');
  led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  HEX: OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
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

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     

PACKAGE alu_pkg IS 
COMPONENT alu IS
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    a             : in  std_logic_vector(7 downto 0); 
    b             : in  std_logic_vector(7 downto 0);
    op            : in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
    result        : out std_logic_vector(7 downto 0)
  );  
END COMPONENT alu;
END PACKAGE alu_pkg;

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     

PACKAGE memory_pkg IS 
COMPONENT memory IS 
  GENERIC (addr_width : INTEGER := 2;
           data_width : INTEGER := 4);
  PORT (
    clk               : IN STD_LOGIC;
    we                : IN STD_LOGIC;
    addr              : IN STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    din               : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
    dout              : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
  );
END COMPONENT memory;
END PACKAGE memory_pkg;