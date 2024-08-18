-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder test bench 
-- REV 1: Math check updated -- Bruce Link 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity generic_adder_tb is
end generic_adder_tb;

architecture arch of generic_adder_tb is

component generic_adder_arch is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component generic_adder_arch;

constant NUM_BITS          : integer := 4;
constant SEQUENTIAL_FLAG   : boolean := true;     -- false : concurrent stimuli, true: sequential stimuli
signal a                   : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
signal b                   : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
signal cin                 : std_logic := '0';
signal sum                 : std_logic_vector(NUM_BITS - 1 downto 0) := (others => '0');
signal cout                : std_logic := '0';
signal cin_guard           : std_logic_vector(NUM_BITS - 2 downto 0) := (others => '0');

begin

uut: generic_adder_arch  
  generic map (
    bits => NUM_BITS
  )
  port map(
    a       => a,
    b       => b,
    cin     => cin,
    sum     => sum,
    cout    => cout
  );

sequential_stimuli: if SEQUENTIAL_FLAG generate
  sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 10 ns;   -- let all the initial conditions trickle through
      for i in 0 to ((2 ** NUM_BITS) - 1) loop
        a <= std_logic_vector(unsigned(a) + 1 );
		cin <= not cin;
        for j in 0 to ((2 ** NUM_BITS) - 1)  loop
          b <= std_logic_vector(unsigned(b) + 1 );
          wait for 10 ns;
        end loop;
      end loop;
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 
end generate sequential_stimuli;

concurrent_stimuli: if not SEQUENTIAL_FLAG generate
	cin <= not cin;
  b(0) <= not b(0) after 10 ns;
  b(1) <= not b(1) after 20 ns;
  a(0) <= not a(0) after 40 ns;
  a(1) <= not a(1) after 80 ns;
end generate concurrent_stimuli;
--1A. sequential_stimuli stops after one run because at the end of the process it reaches a wait statement causing it to wait infinitely
--1B. sequential_stimuli: applies sequential input changes to a and b.
--concurrent_stimuli: It defines concurrent signal changes for a and b.
--1C. The cin signal does not changed at all in either stimuli.

--2A. Only the sequential_stimuli takes into account the number of bits as it ensures all possible input combinations are tested

--3A. The adder uses arithmetic like + and - rather than logic gates

math_check1 : process
  VARIABLE sum_ans : std_logic_vector(NUM_BITS downto 0) := (others => '0');
  VARIABLE sum_var : std_logic_vector(NUM_BITS-1 downto 0) := (others => '0');
  VARIABLE cout_var : std_logic := '0';
  begin
    ---------------------------------------------------------------------------
    -- wait until sum or cout changes. Then wait 1 ns to avoid any delta cycle 
    -- simulations issues of multiple bits changing
    ---------------------------------------------------------------------------
    wait until  (cout'EVENT);
    wait for 1 ns;
    
    sum_ans  := std_logic_vector((unsigned('0' & a) + unsigned('0' & b) + unsigned('0' & cin_guard & cin)));
    sum_var  := sum_ans(NUM_BITS-1 downto 0);
    cout_var := sum_ans(NUM_BITS);
    
    assert (unsigned(sum_var) = unsigned(sum))
    report  "SUM ERROR a:" & integer'image(to_integer(unsigned(a))) & " " & 
            "b:" & integer'image(to_integer(unsigned(b))) & " " &
            "sum:" & integer'image(to_integer(unsigned(sum)));
    
    assert (cout_var = cout)
    report  "COUT ERROR a:" & integer'image(to_integer(unsigned(a))) & " " & 
            "b:" & integer'image(to_integer(unsigned(b))) & " " &
            "cout:" & integer'image(to_integer(unsigned(cin_guard & cout)));
  end process math_check1;

end arch;