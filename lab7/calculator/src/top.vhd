LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.fsm_pkg.ALL;
USE WORK.seven_seg_pkg.ALL;
USE WORK.rising_edge_pkg.ALL;
USE WORK.clock_synchronizer_pkg.ALL;
USE WORK.double_dabble_pkg.ALL;
USE WORK.memory_pkg.ALL;
USE WORK.alu_pkg.ALL;

ENTITY top IS
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
END ENTITY top;

ARCHITECTURE arch OF top IS

  SIGNAL b : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL op_sync : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL mr_sync : STD_LOGIC := '0';
  SIGNAL ms_sync : STD_LOGIC := '0';
  SIGNAL execute_sync : STD_LOGIC := '0';

  SIGNAL reset : STD_LOGIC;

  -- memory
  SIGNAL we : STD_LOGIC;
  SIGNAL a : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL addr : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);

  SIGNAL ones : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL tens : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL hundreds : STD_LOGIC_VECTOR(3 DOWNTO 0);

  SIGNAL result : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL output : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL result_padded : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');

BEGIN
  reset <= not reset_n;

  -- Instance of fsm
  top_fsm : fsm
  GENERIC MAP (data_width => data_width)
  PORT MAP (
    clk => clk,
    reset => reset,
    mr => mr_sync,
    ms => ms_sync,
    execute => execute_sync,
    a => a,
    b => result,
    addr => addr,
    we => we,
    led => led,
    HEX => output
  );
  
  -- memory
  top_mem : memory
  GENERIC MAP (addr_width => addr_width, data_width => data_width)
  PORT MAP (
    clk => clk,
    we => we,
    addr => addr,
    din => output,
    dout => a
  );

  -- alu
  top_alu : alu
  PORT MAP (
    clk => clk,
    reset => reset,
    a => a,
    b => b,
    op => op_sync,
    result => result
  );
  
  -- Input synchronizing
  top_sync_b : clock_synchronizer
  GENERIC MAP (bit_width => data_width)
  PORT MAP (
    clk => clk,
    reset => reset,
    async_in => switch,
    sync_out => b
  );

  top_sync_op : clock_synchronizer
  GENERIC MAP (bit_width => 2)
  PORT MAP (
    clk => clk,
    reset => reset,
    async_in => op,
    sync_out => op_sync
  );

  -- Edge synchronizing
  top_edge_mr : rising_edge_synchronizer
  PORT MAP (
    clk => clk,
    reset => reset,
    input => mr,
    edge => mr_sync
  );

  top_edge_ms : rising_edge_synchronizer
  PORT MAP (
    clk => clk,
    reset => reset,
    input => ms,
    edge => ms_sync
  );

  top_edge_exc : rising_edge_synchronizer
  PORT MAP (
    clk => clk,
    reset => reset,
    input => execute,
    edge => execute_sync
  );

  result_padded <= "0000" & output;

  -- Double Dabble
  top_double_dabble : double_dabble
  PORT MAP (
    result_padded => result_padded,
    ones => ones,
    tens => tens,
    hundreds => hundreds
  );

  -- Seven segment display inst
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
