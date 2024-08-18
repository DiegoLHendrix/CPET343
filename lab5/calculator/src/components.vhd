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

PACKAGE top_pkg IS
COMPONENT top IS
    PORT (
	  clk              : IN  STD_LOGIC;
	  reset            : IN  STD_LOGIC;
	  input_1_async    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	  input_2_async    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	  add_async        : IN  STD_LOGIC; -- Async adder
	  subtractor_async : IN  STD_LOGIC; -- Async subtractor
	  HEX0             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  HEX2             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  HEX4             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
  END COMPONENT top;
END PACKAGE top_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE adder_beh_pkg IS
COMPONENT adder_beh IS
  PORT (
    input_1 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    input_2 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    cin     : IN  STD_LOGIC;
    sum     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    cout    : OUT STD_LOGIC
  );
END COMPONENT adder_beh;
END PACKAGE adder_beh_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE subtractor_beh_pkg IS
COMPONENT subtractor_beh IS
  port (
   input_1 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
   input_2 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
   cin     : IN  STD_LOGIC;
   
   difference : OUT STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
   cout : OUT STD_LOGIC := '0'
   );
END COMPONENT subtractor_beh;
END PACKAGE subtractor_beh_pkg;

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

PACKAGE rising_edge_pkg IS
COMPONENT rising_edge_synchronizer IS 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
END COMPONENT rising_edge_synchronizer;
END PACKAGE rising_edge_pkg;
