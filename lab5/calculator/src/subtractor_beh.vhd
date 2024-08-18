library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor_beh is
  port (
   input_1 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
   input_2 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
   cin     : IN  STD_LOGIC;
   
   difference : OUT STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
   cout : OUT STD_LOGIC := '0'
   );
end entity subtractor_beh;

architecture beh of subtractor_beh is

signal difference_sig   : STD_LOGIC_VECTOR(4 DOWNTO 0):= (OTHERS => '0');
signal cin_sig  : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');

begin
  difference_sig <= std_logic_vector(signed('0' & input_1) - signed('0' & input_2) - signed(cin_sig & cin));
  difference <= difference_sig(3 downto 0);
  cout <= difference_sig(4);
end beh;
