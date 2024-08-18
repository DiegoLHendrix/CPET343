library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.top_pkg.ALL;

entity hw_tb is
end hw_tb;

architecture arch of hw_tb is
    constant period : time := 20 ns;
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
	SIGNAL led : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL switch : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	
	SIGNAL tb_target : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11101011";
	SIGNAL tb_detected : STD_LOGIC := '0';
	SIGNAL dout : STD_LOGIC := '0';
    
begin

-- Component instantiation
uut: top
GENERIC MAP (data_width => 8)
port map(
  clk => clk,
  reset => reset,
  switch => switch,
  led => led,
  dout => dout
  );

-- Clock generator process
clk_gen: process
begin
  clk <= not clk;
  wait for period/2;
end process;

self_check : PROCESS(reset, clk)
BEGIN
  IF (reset = '1') THEN
	  tb_detected <= '0';
    ELSIF RISING_EDGE(clk) THEN
	  FOR i IN 0 TO 7 LOOP
	    IF switch(i) /= tb_target(i) THEN
		  tb_detected <= '0';
		  EXIT;
	    ELSE tb_detected <='1';
		END IF;
	  END LOOP;
	END IF;
END PROCESS self_check;

stmulus: process
begin
  reset <= '1';
  wait for period*2;
  reset <= '0';
  wait for period;
  
  switch <= "11101010";
  wait for period*2;
  switch <= "11101011";
  wait for period*2;
  switch <= "11101010";
  wait for period*2;
  switch <= "11101011";
  wait for period*2;
  switch <= "11101010";
  
  assert dout = tb_detected
    report "tb_detected and dout are not equal. tb_detected = " & std_logic'image(tb_detected) &
    ", dout = " & std_logic'image(dout)
    severity failure;
  
  wait;
end process;
	
end arch;
