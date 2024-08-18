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
    SIGNAL mr : STD_LOGIC := '1';
    SIGNAL ms : STD_LOGIC := '1';
    SIGNAL execute : STD_LOGIC := '1';
    SIGNAL op : STD_LOGIC_VECTOR(1 DOWNTO 0):= (OTHERS => '0');
	SIGNAL switch : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL led : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL bcd_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    
    -- Declare the procedure
    procedure press_button(signal button : out std_logic) is
    begin
        wait for period;
        wait for period;
        wait for period;
        button <= '0';
        wait for period;
        wait for period;
        wait for period;
        button <= '1';
        wait for period;
        wait for period;
        wait for period;
    end procedure;
	
begin

-- Component instantiation
uut: top
GENERIC MAP ( addr_width => 2,
data_width => 8)
port map(
  clk => clk,
  reset_n => reset,
  mr => mr,
  ms => ms,
  execute => execute,
  op => op,
  switch => switch,
  led => led,
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
  switch <= "00000100"; --4
  reset <= '0';
  
  wait for period;
  reset <= '1';
  wait for period;
  execute <= '0';
  wait for period;
  execute <= '1';
  wait for period;
  
  switch <= "00001000"; --8
  op <= "10";
  
  press_button(execute);
  
  press_button(ms);
  
  op <= "01";
  
  press_button(execute);
  
  switch <= "00000010"; --2
  op <= "11";
  press_button(execute);
  
  press_button(mr);
  press_button(execute);
  
  
  wait;
end process;
	
end arch;
