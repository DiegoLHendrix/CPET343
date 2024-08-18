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
  a : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  dout : OUT STD_LOGIC := '0'
  );
END ENTITY fsm;

ARCHITECTURE Behavioral OF fsm IS

  TYPE State IS (READ_VAL, CHECK_VAL,VAL_TRUE, VAL_FALSE);
  SIGNAL CurrentState, NextState : State;
  
  SIGNAL target : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := "11101011";
  SIGNAL detected : STD_LOGIC := '0';
BEGIN

  clk_state : PROCESS(clk, reset)
  BEGIN
    IF (reset = '1') THEN
      CurrentState <= READ_VAL;
    ELSIF RISING_EDGE(clk) THEN
      CurrentState <= NextState;
    END IF;
  END PROCESS clk_state;

  -- State transitions
  update_state : PROCESS(CurrentState, detected)
  BEGIN
    CASE CurrentState IS
      WHEN READ_VAL =>
	    NextState <= CHECK_VAL;
	
	  WHEN CHECK_VAL =>
	    IF (detected = '1') THEN
		  NextState <= VAL_TRUE;
	    ELSE NextState <= VAL_FALSE;
		END IF;
	
	  WHEN VAL_TRUE =>
	    NextState <= READ_VAL;
	
	  WHEN VAL_FALSE =>
	    NextState <= READ_VAL;
		
    END CASE;
  END PROCESS update_state;

  -- Handle outputs
  NS_decode : PROCESS(CurrentState, a)
    BEGIN
    CASE CurrentState IS
	  WHEN READ_VAL => 
	    led <= (OTHERS => '0');
	  
	  WHEN CHECK_VAL => 
	    led <= "0001";
		
	  WHEN VAL_TRUE => 
	    led <= "1111";
	  
	  WHEN VAL_FALSE => 
	    led <= "0011";

    END CASE;
  END PROCESS NS_decode;
  
  check_proc : PROCESS(clk, reset)
  BEGIN
    IF (reset = '1') THEN
	  detected <= '0';
    ELSIF RISING_EDGE(clk) THEN
	  FOR i IN 0 TO data_width-1 LOOP
	    IF a(i) /= target(i) THEN
		  detected <= '0';
		  EXIT;
	    ELSE detected <='1';
		END IF;
	  END LOOP;
	END IF;
  END PROCESS check_proc;
  dout <= detected;
END ARCHITECTURE Behavioral;
