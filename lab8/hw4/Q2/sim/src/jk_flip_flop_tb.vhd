library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.jkff_pkg.ALL;

entity jk_flip_flop_tb is
end jk_flip_flop_tb;

architecture arch of jk_flip_flop_tb is
    constant period : time := 50 ns;
    
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL clear : STD_LOGIC := '1';
    SIGNAL preset : STD_LOGIC := '1';

    SIGNAL j : STD_LOGIC := '0';
    SIGNAL k : STD_LOGIC := '0';
    SIGNAL q : STD_LOGIC := '0';
    SIGNAL qn : STD_LOGIC := '0';

     -- Declare the procedure
     procedure press_button(signal button : out std_logic) is
      begin
          wait for period;
          button <= '0';
          wait for period;
          button <= '1';
          wait for period;
      end procedure;
    
begin

-- Component instantiation
uut: jk_flip_flop
port map(
  clk => clk,
  clear => clear, 
  preset => preset, 
  
  j => j,
  k => k,

  q => q,
  qn => qn
  );

-- Clock generator process
clk_gen: process
begin
  clk <= not clk;
  wait for period/2;
end process;

stmulus: process
begin
  wait for period;

  j <= '0';
  k <= '1';
  wait for period;

  j <= '1';
  k <= '0';
  wait for period;

  j <= '1';
  k <= '1';
  wait for period;

  j <= '1';
  k <= '0';
  wait for period;

  press_button(clear);
  wait for period;

  j <= '0';
  k <= '1';
  wait for period;

  press_button(preset);
  wait for period;

  assert q /= qn
    report "Que and not_que are equal. Que = " & std_logic'image(q) &
    ", QN = " & std_logic'image(qn)
    severity failure;

  wait;
end process;
	
end arch;
