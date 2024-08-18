-- Dr. Kaputa
-- Lab 9: DJ Roomba 3000 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dj_roomba_3000 is 
  port(
    clk                 : in std_logic;
    reset               : in std_logic;
    execute_btn         : in std_logic;
    sync                : in std_logic;
    led                 : out std_logic_vector(7 downto 0) := (OTHERS => '0');
    audio_out           : out std_logic_vector(15 downto 0)
  );
end dj_roomba_3000;

architecture beh of dj_roomba_3000 is
  -- instruction memory
  component rom_instructions
    port(
      address    : in std_logic_vector (4 DOWNTO 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 DOWNTO 0)
    );
  end component;
  
  -- data memory
  component rom_data
    port(
      address  : in std_logic_vector (13 DOWNTO 0);
      clock    : in std_logic  := '1';
      q        : out std_logic_vector (15 DOWNTO 0)
    );
  end component;
  
signal data_address  : std_logic_vector(13 downto 0);

COMPONENT rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
END COMPONENT rising_edge_synchronizer;

-- States
TYPE State IS (IDLE, FETCH, DECODE, EXECUTE, DECODE_ERROR);
SIGNAL CurrentState, NextState : State;

SIGNAL inst_address : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
SIGNAL current_instructions : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
SIGNAL instruction : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
SIGNAL error : STD_LOGIC := '0';
SIGNAL execute_sync : STD_LOGIC := '0';

SIGNAL play_once : STD_LOGIC := '0';
SIGNAL play_complete : STD_LOGIC := '0';
SIGNAL play_repeat : STD_LOGIC := '0';
SIGNAL pause : STD_LOGIC := '0';
SIGNAL seek : STD_LOGIC := '0';
SIGNAL stop : STD_LOGIC := '0';

CONSTANT INSTR_PLAY : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
CONSTANT INSTR_REPEAT : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
CONSTANT INSTR_PAUSE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
CONSTANT INSTR_SEEK : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
CONSTANT INSTR_STOP : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
begin

-- data instantiation
u_rom_data_inst : rom_data
  port map (
    address    => data_address,
    clock      => clk,
    q          => audio_out
  );

u_rom_instructions_inst : rom_instructions
  port map (
    address    => inst_address,
    clock      => clk,
    q          => instruction
  );
  
-- loop audio file
PROCESS(clk,reset,sync)
BEGIN 
IF (reset = '1') THEN 
  data_address <= (OTHERS => '0');
  play_complete <= '0';
ELSIF (clk'event AND clk = '1') THEN
  IF (sync = '1') THEN
    IF (play_once = '1') THEN
	  IF (data_address = "11111111111111") THEN
	    play_complete <= '1';
	  END IF;

	  IF (play_complete = '0') THEN
	    data_address <= std_logic_vector(unsigned(data_address) + 1 );
	  ELSE data_address <= data_address;
	  END IF;

    ELSIF (play_repeat = '1') THEN
	  data_address <= std_logic_vector(unsigned(data_address) + 1 );
	  play_complete <= '0';

    ELSIF (pause = '1') THEN
	  data_address <= data_address;
	  play_complete <= '0';

    ELSIF (seek = '1') THEN
	  data_address <= current_instructions(4 DOWNTO 0) & "000000000";
	  play_complete <= '0';

    ELSIF (stop = '1') THEN
  	  data_address <= (OTHERS => '0');
	  play_complete <= '0';

	END IF;
  END IF;
END IF;
END PROCESS;

-- Clk transition
clk_state : PROCESS(clk, reset)
BEGIN
IF (reset = '1') THEN
  CurrentState <= IDLE;
ELSIF RISING_EDGE(clk) THEN
  CurrentState <= NextState;
END IF;
END PROCESS clk_state;

-- Edge synchronizing
top_edge_exc : rising_edge_synchronizer
PORT MAP (
  clk => clk,
  reset => reset,
  input => execute_btn,
  edge => execute_sync
  );

-- State transitions
update_state : PROCESS(CurrentState, error, execute_sync)
BEGIN
CASE CurrentState IS
  WHEN IDLE =>
	IF(execute_sync = '1') THEN
	  NextState <= FETCH;
	ELSE NextState <= IDLE;
	END IF;

  WHEN FETCH =>
    NextState <= DECODE;

  WHEN DECODE =>
	IF (error = '1') THEN 
	  NextState <= DECODE_ERROR;
	ELSE NextState <= EXECUTE;
	END IF;

  WHEN EXECUTE =>
    NextState <= IDLE;

  WHEN DECODE_ERROR =>
	NextState <= IDLE;

  WHEN OTHERS =>
	NextState <= IDLE;  -- Default state assignment
	
END CASE;
END PROCESS update_state;

-- Handle outputs
NS_decode : PROCESS(clk, reset)
BEGIN
IF (reset = '1') THEN
  error <= '0';
  play_once <= '0';
  play_repeat <= '0';
  pause <= '0';
  seek <= '0';
  stop <= '0';
  led <= current_instructions;
  
ELSIF RISING_EDGE(clk) THEN
  IF CurrentState = DECODE THEN
	IF (current_instructions = "00000000") THEN
	  error <= '0';
	  play_once <= '1';
	  play_repeat <= '0';
	  pause <= '0';
	  seek <= '0';
	  stop <= '0';

	ELSIF (current_instructions(7 DOWNTO 5) = INSTR_REPEAT) THEN
	  error <= '0';
	  play_once <= '0';
	  play_repeat <= '1';
	  pause <= '0';
	  seek <= '0';
	  stop <= '0';

	ELSIF (current_instructions(7 DOWNTO 6) = INSTR_PAUSE) THEN
	  error <= '0';
	  play_once <= '0';
	  play_repeat <= '0';
	  pause <= '1';
	  seek <= '0';
	  stop <= '0';

	ELSIF (current_instructions(7 DOWNTO 6) = INSTR_SEEK) THEN
	  error <= '0';
	  play_once <= '0';
	  play_repeat <= '0';
	  pause <= '0';
	  seek <= '1';
	  stop <= '0';

	ELSIF (current_instructions(7 DOWNTO 6) = INSTR_STOP) THEN
	  error <= '0';
	  play_once <= '0';
	  play_repeat <= '0';
	  pause <= '0';
	  seek <= '0';
	  stop <= '1';

	ELSE 
	  error <= '1';
	  play_once <= '0';
	  play_repeat <= '0';
	  pause <= '0';
	  seek <= '0';
	  stop <= '0';

	END IF;

  ELSIF (CurrentState = EXECUTE) THEN
	led <= current_instructions;

  ELSIF (CurrentState = DECODE_ERROR) THEN
	led <= "11111111";
  END IF;
END IF;
END PROCESS NS_decode;

inst_proc: PROCESS(clk,reset)
BEGIN
  IF (reset = '1') THEN
    current_instructions <= (OTHERS => '0'); -- Reset Instructions
	inst_address <= (OTHERS => '0');	-- Reset Instructions
  ELSIF RISING_EDGE(clk) THEN
    IF (NextState = FETCH) THEN
	  inst_address <= STD_LOGIC_VECTOR(UNSIGNED(inst_address) + 1); -- Increment instruction address
	  current_instructions <= instruction; -- Send instruction to the updated register
	  END IF;
	END IF;
	
END PROCESS inst_proc;
END beh;