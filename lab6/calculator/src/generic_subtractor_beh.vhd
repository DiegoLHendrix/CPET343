-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic subtractor [behavioral]
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY generic_subtractor_beh IS
  GENERIC (
    bits    : INTEGER := 4
  );
  PORT (
    a       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
    b       : IN  STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
    cin     : IN  STD_LOGIC;
    difference     : OUT STD_LOGIC_VECTOR(bits-1 DOWNTO 0) := (OTHERS => '0');
    cout    : OUT STD_LOGIC
  );
END ENTITY generic_subtractor_beh;

ARCHITECTURE beh OF generic_subtractor_beh IS

SIGNAL difference_temp   : STD_LOGIC_VECTOR(bits DOWNTO 0);
SIGNAL cin_guard  : STD_LOGIC_VECTOR(bits-1 DOWNTO 0) := (OTHERS => '0');

BEGIN
  difference_temp  <= STD_LOGIC_VECTOR(UNSIGNED('0' & a) - UNSIGNED('0' & b) - UNSIGNED(cin_guard & cin));
  difference       <= difference_temp(bits-1 DOWNTO 0);
  cout      <= difference_temp(bits); -- Carry is the most significant bit
END beh;