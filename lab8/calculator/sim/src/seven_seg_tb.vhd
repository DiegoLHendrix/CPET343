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
    SIGNAL execute : STD_LOGIC := '1';
	
	SIGNAL led : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    
    -- Declare the procedure
    procedure press_button(signal button : out std_logic) is
    begin
        wait for period*3;
        button <= '0';
        wait for period*3;
        button <= '1';
        wait for period*3;
    end procedure;
	
begin

-- Component instantiation
uut: top
GENERIC MAP ( addr_width => 2,
data_width => 8)
port map(
  clk => clk,
  reset_n => reset,
  execute => execute,
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
  
  reset <= '0';
  wait for period*2;
  reset <= '1';

  wait for period;

  press_button(execute);
  press_button(execute);
  press_button(execute);
  press_button(execute);
  press_button(execute);
  press_button(execute);
  press_button(execute);
  
  wait;
end process;
	
end arch;
