library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.dff_pkg.ALL;

entity d_flip_flop_tb is
end d_flip_flop_tb;

architecture arch of d_flip_flop_tb is
    constant period : time := 20 ns;
    
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL preset : STD_LOGIC := '0';
    SIGNAL data : STD_LOGIC := '0';
    SIGNAL que : STD_LOGIC := '0';
    SIGNAL not_que : STD_LOGIC := '0';

     -- Declare the procedure
     procedure press_button(signal button : out std_logic) is
      begin
          -- wait for period;
          button <= '1';
          wait for period;
          button <= '0';
          wait for period;
      end procedure;
    
begin

-- Component instantiation
uut: d_flip_flop
port map(
  clk => clk,
  reset => reset, 
  preset => preset, 
  data => data,
  que => que,
  not_que => not_que
  );

-- Clock generator process
clk_gen: process
begin
  clk <= not clk;
  wait for period/2;
end process;

stmulus: process
begin
  
  -- button is pressed
  press_button(data);
  press_button(data);

  -- reset is pressed while data is high
  data <= '1';
  reset <= '0';
  wait for period;
  reset <= '1';
  data <= '0';
  wait for period;

  -- button is pressed
  press_button(data);
  press_button(data);

  -- preset is pressed
  preset <= '1';
  wait for period;
  preset <= '0';
  wait for period;

  -- button is pressed
  press_button(data);
  press_button(data);

  -- reset is pressed while data is high
  data <= '1';
  reset <= '0';
  wait for period;
  reset <= '1';
  data <= '0';
  wait for period;

  -- button is pressed
  press_button(data);
  press_button(data);

  -- preset is pressed
  preset <= '1';
  wait for period;
  preset <= '0';
  wait for period;

  -- button is pressed
  press_button(data);
  press_button(data);

  assert que = data
    report "Que and data are not equal. Que = " & std_logic'image(que) & 
    ", Data = " & std_logic'image(data)
    severity failure;

  assert que /= not_que
    report "Que and not_que are equal. Que = " & std_logic'image(que) &
    ", Not_que = " & std_logic'image(not_que)
    severity failure;

  wait;
end process;
	
end arch;
