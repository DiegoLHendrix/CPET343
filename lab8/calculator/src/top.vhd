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
USE WORK.rom_pkg.ALL;

ENTITY top IS
GENERIC (
  addr_width : INTEGER := 2;
  data_width : INTEGER := 8
);
PORT (
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC;
  execute : IN STD_LOGIC;
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  bcd_0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  bcd_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  bcd_2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END ENTITY top;

ARCHITECTURE arch OF top IS

  -- FSM
  SIGNAL a : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL b : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL mem_out : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL op : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL execute_sync : STD_LOGIC;
  SIGNAL reset : STD_LOGIC;

  -- Memory
  SIGNAL we : STD_LOGIC;
  SIGNAL ram_addr : STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);

  -- ROM
  SIGNAL q : STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL rom_addr : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
  
  -- Double Dabble
  SIGNAL ones : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL tens : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL hundreds : STD_LOGIC_VECTOR(3 DOWNTO 0);

  -- Outputs
  SIGNAL result : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL result_padded : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
  
BEGIN
  reset <= not reset_n;

  -- Instance of fsm
  top_fsm : fsm
  GENERIC MAP (
    data_width => data_width
    )
  PORT MAP (
    clk => clk,
    reset => reset,
    execute => execute_sync,
    a => a,
    b => result,
    rom_data => q,
    ram_addr => ram_addr,
    we => we,
    led => led,
  	rom_addr => rom_addr,
	  mem_out => mem_out
    );
  
  -- memory
  top_mem : memory
  GENERIC MAP (
    addr_width => addr_width, 
    data_width => data_width
    )
  PORT MAP (
    clk => clk,
    we => we,
    addr => ram_addr,
    din => mem_out,
    dout => a
    );
  
  rom_inst : rom 
  PORT MAP (
    address => rom_addr,
	  clock => clk,
	  q => q
	  );
	
  -- alu
  top_alu : alu
  PORT MAP (
    clk => clk,
    reset => reset,
    a => a,
    b => q(7 DOWNTO 0),
    op => q(11 DOWNTO 10),
    result => result
    );
  
  -- Edge synchronizing
  top_edge_exc : rising_edge_synchronizer
  PORT MAP (
    clk => clk,
    reset => reset,
    input => execute,
    edge => execute_sync
    );

  result_padded <= "0000" & a;

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
