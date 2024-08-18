library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_beh is
  port (
    input_1 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    input_2 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    cin     : IN  STD_LOGIC;
	
    sum : OUT STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
    cout : OUT STD_LOGIC := '0'
  );
end entity adder_beh;

architecture beh of adder_beh is

signal sum_sig   : STD_LOGIC_VECTOR(4 DOWNTO 0):= (OTHERS => '0');
signal cin_sig  : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');

begin
  sum_sig <= std_logic_vector(unsigned('0' & input_1) + unsigned('0' & input_2) + unsigned(cin_sig & cin));
  sum <= sum_sig(3 downto 0);
  cout <= sum_sig(4);
end beh;
