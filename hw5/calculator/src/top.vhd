LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.fsm_pkg.ALL;

ENTITY top IS
GENERIC (
  data_width : INTEGER := 8
);
PORT (
  clk : IN STD_LOGIC;
  reset : IN STD_LOGIC;
  switch : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  led : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  dout : OUT STD_LOGIC
  );
END ENTITY top;

ARCHITECTURE arch OF top IS

BEGIN

  -- Instance of fsm
  top_fsm : fsm
  GENERIC MAP (
    data_width => data_width
    )
  PORT MAP (
    clk => clk,
    reset => reset,
    a => switch,
    led => led,
	dout => dout
    );
END ARCHITECTURE arch;
