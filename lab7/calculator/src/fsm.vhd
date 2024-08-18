LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm IS
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
END ENTITY fsm;

ARCHITECTURE Behavioral OF fsm IS

  TYPE State IS (READ_MEM, SAVE_MEM, EXECUTE_MEM, LOAD_MEM, ADD_TO_MEM);

  SIGNAL CurrentState, NextState : State;

  SIGNAL led_output : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
  SIGNAL output : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL addr_sig : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

  clk_state : PROCESS(clk, reset)
  BEGIN
    IF (reset = '1') THEN
      CurrentState <= READ_MEM;
    ELSIF rising_edge(clk) THEN
      CurrentState <= NextState;
    END IF;
  END PROCESS clk_state;

  -- State transitions
  update_state : PROCESS(CurrentState, mr, ms, execute)
  BEGIN
    CASE CurrentState IS
      WHEN READ_MEM =>
        IF (mr = '1'AND ms = '0' AND execute = '0') THEN
          NextState <= LOAD_MEM;
        ELSIF (mr = '0' AND ms = '1' AND execute = '0') THEN
          NextState <= SAVE_MEM;
        ELSIF (mr = '0' AND ms ='0' AND execute = '1') THEN
          NextState <= EXECUTE_MEM;
        ELSE
          NextState <= READ_MEM;
        END IF;
        
      WHEN EXECUTE_MEM =>
        NextState <= READ_MEM;
		
      WHEN SAVE_MEM =>
        NextState <= READ_MEM;
		
      WHEN LOAD_MEM =>
        IF (execute = '1') THEN
          NextState <= READ_MEM;
        ELSE
          NextState <= ADD_TO_MEM;  -- Transition to ADD_TO_MEM to add 'a' to memory
        END IF;
        
      WHEN ADD_TO_MEM =>
        NextState <= READ_MEM;
		
      WHEN OTHERS =>
        NextState <= READ_MEM;  -- Default state assignment
		
    END CASE;
  END PROCESS update_state;

  -- Handle outputs
  NS_decode : PROCESS(CurrentState, reset)
  BEGIN
    IF (reset = '1') THEN
      led_output <= "0001";
      we <= '0';
      addr_sig <= "00";
      output <= (OTHERS => '0');
        
    ELSE
      CASE CurrentState IS
        WHEN READ_MEM => 
          we <= '0';
          addr_sig <= "00";
          
        WHEN EXECUTE_MEM => 
          led_output <= "0011";
          we <= '1';
          addr_sig <= "00";
          output <= b; -- Use the result from the ALU, mapped to 'b'
          
        WHEN SAVE_MEM => 
          led_output <= "0111";
          we <= '1';
          addr_sig <= "01";
          
        WHEN LOAD_MEM => 
          led_output <= "1111";
          we <= '0';
          addr_sig <= "01";
          
        WHEN ADD_TO_MEM =>
          -- Add 'a' to memory address 00
          led_output <= "1111";  -- Indicate the ADD_TO_MEM state on LEDs
          we <= '1';
          addr_sig <= "00";
          output <= a;  -- Output 'a' to memory address 00
		  
        WHEN OTHERS =>
          led_output <= "0001";  -- Default led output state
          we <= '0';
          addr_sig <= "00";
      END CASE;
    END IF;
  END PROCESS NS_decode;

  led <= "000000" & led_output;
  HEX <= output;
  addr <= addr_sig;

END ARCHITECTURE Behavioral;
