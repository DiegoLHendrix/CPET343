LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm IS
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC := '0';
  button_sync : IN STD_LOGIC := '0';
  switch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  sum : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
  difference : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
  a : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
  b : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  HEX : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END ENTITY fsm;

ARCHITECTURE Behavioral OF fsm IS

TYPE State IS (INPUT_A, INPUT_B, DISP_DIF, DISP_SUM);

SIGNAL CurrentState, NextState : State;

SIGNAL a_sig : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
SIGNAL b_sig : STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');

SIGNAL hex_output : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
SIGNAL led_output : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');

BEGIN
   -- clk state transition process
  clk_State : PROCESS(reset,button_sync)
  BEGIN
    IF (reset = '1') THEN
      CurrentState <= INPUT_A;
	ELSIF rising_edge(button_sync) THEN
	  CurrentState <= NextState;
    END IF;
  END PROCESS clk_State;
 
   -- State transitions
  update_state : PROCESS(CurrentState)
  BEGIN
    CASE CurrentState IS
	  WHEN INPUT_A => --Input a
	    NextState <= INPUT_B;
		
	  WHEN INPUT_B => --Input b
	    NextState <= DISP_SUM;

	  WHEN DISP_SUM => --Dsiplay sum
	    NextState <= DISP_DIF;
	  
	  WHEN DISP_DIF => --Dsiplay difference
	    NextState <= INPUT_A;
	  
    END CASE;
  END PROCESS update_state;
  
  -- Handle outputs
  NS_decode : PROCESS(button_sync,CurrentState,reset,switch,sum,difference)
  BEGIN
  IF (reset = '1') THEN
	  a_sig <= (others => '0');
	  b_sig <= (others => '0');
	  hex_output <= (others => '0');
	  led_output <= (others => '0');
  ELSE
    CASE CurrentState IS
	  WHEN INPUT_A => --Input a
	    a_sig <=  "0" & switch;
	    hex_output <= "0000" & switch;
	    led_output <= "0000000001";
		
	  WHEN INPUT_B => --Input b
	    b_sig <= "0" & switch;
	    hex_output <= "0000" & switch;
	    led_output <= "0000000011";

	  WHEN DISP_SUM => --Dsiplay sum
	    hex_output <= "000" & sum;
	    led_output <= "0000000111";
	  
	  WHEN DISP_DIF => --Dsiplay difference
	    hex_output <= "000" & difference;
	    led_output <= "0000001111";
		
     END CASE;
	END IF;
  END PROCESS NS_decode;
  
  a <= a_sig;
  b <= b_sig;
  led <= led_output;
  HEX <= hex_output;
END ARCHITECTURE Behavioral;
