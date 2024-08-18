LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm IS
GENERIC (
  data_width : INTEGER := 8
  );
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  execute : IN STD_LOGIC;
  a : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  b : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  rom_data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
  we : OUT STD_LOGIC := '1';
  ram_addr : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
  rom_addr : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  mem_out: OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
  );
END ENTITY fsm;

ARCHITECTURE Behavioral OF fsm IS

  TYPE State IS (READ_MEM, SAVE_MEM, EXECUTE_MEM, LOAD_MEM, ADD_TO_MEM);
  SIGNAL CurrentState, NextState : State;
  
  SIGNAL rom_sig : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
BEGIN

  clk_state : PROCESS(clk, reset)
  BEGIN
    IF (reset = '1') THEN
      CurrentState <= READ_MEM;
    ELSIF RISING_EDGE(clk) THEN
      CurrentState <= NextState;
    END IF;
  END PROCESS clk_state;

  -- State transitions
  update_state : PROCESS(CurrentState, rom_data, execute)
  BEGIN
    CASE CurrentState IS
      WHEN READ_MEM =>
        IF (rom_data(9 DOWNTO 8) = "01" AND execute = '1') THEN
          NextState <= LOAD_MEM;
        ELSIF (rom_data(9 DOWNTO 8) = "10" AND execute = '1') THEN
          NextState <= SAVE_MEM;
        ELSIF (execute = '1') THEN
          NextState <= EXECUTE_MEM;
        ELSE
          NextState <= READ_MEM;
        END IF;
        
      WHEN EXECUTE_MEM =>		  
        NextState <= READ_MEM;
		
      WHEN SAVE_MEM =>
        NextState <= READ_MEM;
		
      WHEN LOAD_MEM =>
	      NextState <= ADD_TO_MEM;  -- Transition to ADD_TO_MEM to add 'a' to memory
        
      WHEN ADD_TO_MEM =>
        NextState <= READ_MEM;
		
      WHEN OTHERS =>
        NextState <= READ_MEM;  -- Default state assignment
		
    END CASE;
  END PROCESS update_state;

  -- Handle outputs
  NS_decode : PROCESS(CurrentState, a, b)
    BEGIN
    CASE CurrentState IS
	  WHEN READ_MEM => 
	    we <= '0';
	    ram_addr <= "00";
		  mem_out <= (OTHERS => '0');
	  
	  WHEN EXECUTE_MEM => 
	    led <= "0011";
	    we <= '1';
	    ram_addr <= "00";
	  	mem_out <= b;
	  
	  WHEN SAVE_MEM => 
	    led <= "0111";
	    we <= '1';
	    ram_addr <= "01";
		  mem_out <= a;
	  
	  WHEN LOAD_MEM => 
	    led <= "1111";
	    we <= '0';
	    ram_addr <= "01";
		  mem_out <= a;
	  
	  WHEN ADD_TO_MEM =>
	    -- Add 'a' to memory address 00
	    led <= "1111";  -- Indicate the ADD_TO_MEM state on LEDs
	    we <= '1';
	    ram_addr <= "00";
		  mem_out <= a;
	  
	  WHEN OTHERS =>
	    led <= "0001";  -- Default led output state
	    we <= '0';
	    ram_addr <= "00";
		  mem_out <= (OTHERS => '0');
  
    END CASE;
  END PROCESS NS_decode;
  
  rom_addr_proc : PROCESS(clk, reset)
    BEGIN
	  IF (reset = '1') THEN
	    rom_sig <= (OTHERS => '0');
	  ELSIF RISING_EDGE(clk) THEN
	    IF (CurrentState = EXECUTE_MEM) OR (CurrentState = SAVE_MEM) OR (CurrentState = ADD_TO_MEM) THEN
		  rom_sig <= STD_LOGIC_VECTOR(UNSIGNED(rom_sig) + 1);
		END IF;
	  END IF;
	END PROCESS rom_addr_proc;
	
rom_addr <= rom_sig;

END ARCHITECTURE Behavioral;
