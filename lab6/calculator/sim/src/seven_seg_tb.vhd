library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.top_pkg.ALL;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is
    constant period : time := 20 ns;
    
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL button : STD_LOGIC := '1';
	SIGNAL switch : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL bcd_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    
begin

-- Component instantiation
uut: top
port map(
  clk => clk,
  reset => reset,
  button_async => button,
  switch => switch,
  bcd_0 => bcd_0,
  bcd_1 => bcd_1,
  bcd_2 => bcd_2
  );

-- Clock generator process
clk_gen: process
begin
  clk <= not clk;
  wait for period/2;
end process;

stmulus: process
begin
  reset <= '0';

  switch <= "00000101"; --5
  
-- State 2
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "00000010"; --2
  
-- State 3
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 4
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 1
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "00000010"; --2
  
-- State 2
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "00000101"; --5
  
-- State 3
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 4
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 1
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;

  switch <= "11001000"; --200
  
-- State 2
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "01100100"; --100
  
-- State 3
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 4
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 1
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "01100100"; --100

-- State 2
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  switch <= "11001000"; --200

-- State 3
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
-- State 4
  button <= not button;
  wait for period;
  button <= not button;
  wait for period;
  
  wait;
end process;
	
end arch;

--0001 1111 1101 = 509
-- 1111 1111 1101 = 4093