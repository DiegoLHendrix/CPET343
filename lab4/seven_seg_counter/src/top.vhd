LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.seven_seg_pkg.ALL;
USE work.generic_counter_pkg.ALL;
USE work.generic_adder_pkg.ALL;
USE work.generic_sum_register_pkg.ALL;

PACKAGE top_pkg IS
  COMPONENT top IS
      GENERIC (
          bits : integer := 4;
          max : integer := 50000000 --50MHz to update the display at 1 Hz
      );
      PORT (
          CLOCK_50 : in std_logic;
          HEX0 : out std_logic_vector(6 downto 0);
          HEX2 : out std_logic_vector(6 downto 0);
          HEX4 : out std_logic_vector(6 downto 0)
      );
  END COMPONENT top;
END PACKAGE top_pkg;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.seven_seg_pkg.ALL;
USE work.generic_counter_pkg.ALL;
USE work.generic_adder_pkg.ALL;
USE work.generic_sum_register_pkg.ALL;

ENTITY top IS
    GENERIC (
        bits : integer := 4;
        max : integer := 50000000
    );
    PORT (
        CLOCK_50 : in std_logic;
        HEX0 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX4 : out std_logic_vector(6 downto 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS
  SIGNAL sum_sig : std_logic_vector(3 downto 0) := (others => '0'); -- Sum as input
  SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0'); -- Sum as output
  SIGNAL enable : STD_LOGIC := '0';

BEGIN

  -- Adder instance
  top_adder: generic_adder_beh
    GENERIC MAP (bits => bits) 
    PORT MAP (
	  a => sum_sig,
	  b => "0001",
	  sum => sum,
	  cin => '0',
	  cout => open
    );

  -- Counter instance
  top_counter: generic_counter
    GENERIC MAP (max => max)
    PORT MAP (
	  clk => CLOCK_50,
	  reset => '0',
	  output => enable
    );

  -- Sum register instance
  top_sum: generic_sum_register
    PORT MAP (
	  clk => CLOCK_50,
	  sum => sum,
	  enable => enable,
	  sum_sig => sum_sig
    );
	
  -- Seven segment display instance
  top_seven : seven_seg
    PORT MAP (
	  enable => enable,
	  bcd => sum_sig, -- in
	  seven_seg_out => HEX0, -- out
	  seven_seg_out2 => HEX2,  -- out
	  seven_seg_out3 => HEX4  -- out
	  );

END ARCHITECTURE arch;
