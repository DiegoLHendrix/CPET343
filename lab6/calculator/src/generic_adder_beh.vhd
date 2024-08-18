-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic adder [behavioral]
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY generic_adder_beh IS
  GENERIC (
    bits    : INTEGER := 4
  );
  PORT (
    a       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
    b       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
    cin     : IN  STD_LOGIC;
    sum     : OUT STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
    cout    : OUT STD_LOGIC
  );
END ENTITY generic_adder_beh;

ARCHITECTURE beh OF generic_adder_beh IS

SIGNAL sum_temp   : STD_LOGIC_VECTOR(bits DOWNTO 0);
SIGNAL cin_guard  : STD_LOGIC_VECTOR(bits-1 DOWNTO 0) := (OTHERS => '0');

BEGIN
  sum_temp  <= STD_LOGIC_VECTOR(UNSIGNED('0' & a) + UNSIGNED('0' & b) + UNSIGNED(cin_guard & cin));
  sum       <= sum_temp(bits-1 DOWNTO 0);
  cout      <= sum_temp(bits); -- Carry is the most significant bit
END beh;