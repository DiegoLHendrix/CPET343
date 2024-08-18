LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.fsm_pkg.ALL;
USE WORK.seven_seg_pkg.ALL;
USE WORK.rising_edge_pkg.ALL;
USE WORK.clock_synchronizer_pkg.ALL;
USE WORK.generic_adder_pkg.ALL;
USE WORK.generic_subtractor_pkg.ALL;
USE WORK.double_dabble_pkg.ALL;

ENTITY top IS
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
END ENTITY top;

ARCHITECTURE arch OF top IS
SIGNAL switch_sync : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL button_sync : STD_LOGIC;
SIGNAL button_sig : STD_LOGIC := '0';
SIGNAL mux : STD_LOGIC;

SIGNAL ones : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
SIGNAL tens : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
SIGNAL hundreds : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

SIGNAL a : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL b : STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL sum : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL difference : STD_LOGIC_VECTOR(8 DOWNTO 0);

SIGNAL output : STD_LOGIC_VECTOR(11 DOWNTO 0);
	
BEGIN
  
  -- Finite state machine instantiation
  top_fsm: fsm
  PORT MAP (
    clk => clk,
    reset => reset,
    button_sync => button_sync,
    switch => switch_sync,
	sum => sum,
	difference => difference,
	a => a,
	b => b,
	led => led,
	HEX => output
	);
  
  -- Input synchronizing
  top_sync_input_a : clock_synchronizer
  GENERIC MAP (bit_width => 8)
  PORT MAP (
    clk => clk,
	reset => reset,
	async_in => switch,
	sync_out => switch_sync
	);

  -- Edge synchronizing
  top_edge_button : rising_edge_synchronizer
  PORT MAP (
    clk => clk,
	reset => reset,
	input => button_async,
	edge => button_sync
	);
	
  -- Adder
  top_adder : generic_adder_beh
  GENERIC MAP (bits => 9)
  PORT MAP (
    a => a,
	b => b,
	cin => '0',
	sum => sum,
	cout => OPEN
	);

  -- Subtractor
  top_subtractor : generic_subtractor_beh
  GENERIC MAP (bits => 9)
  PORT MAP (
    a => a,
	b => b,
	cin => '0',
	difference => difference,
	cout => OPEN
	);

  top_double_dabble : double_dabble
  PORT MAP (
    result_padded => output,
	ones => ones,
	tens => tens,
	hundreds => hundreds
	);
	
  --Seven segment display instantiation
  top_seven_seg0 : seven_seg
  PORT MAP (
    bcd => ones,
	HEX => bcd_0
	);

  top_seven_seg1 : seven_seg
  PORT MAP (
    bcd => tens,
	HEX => bcd_1
	);

  top_seven_seg2 : seven_seg
  PORT MAP (
    bcd => hundreds,
	HEX => bcd_2
	);
END ARCHITECTURE arch;
