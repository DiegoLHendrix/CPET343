LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.seven_seg_pkg.ALL;
USE WORK.clock_synchronizer_pkg.ALL;
USE WORK.adder_beh_pkg.ALL;
USE WORK.subtractor_beh_pkg.ALL;
USE WORK.rising_edge_pkg.ALL;

ENTITY top IS
    PORT (
	  clk              : IN  STD_LOGIC;
	  reset            : IN  STD_LOGIC;
	  input_1_async    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	  input_2_async    : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	  add_async        : IN  STD_LOGIC; -- Async adder
	  subtractor_async : IN  STD_LOGIC; -- Async subtractor
	  HEX0             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  HEX2             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	  HEX4             : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY top;

ARCHITECTURE arch OF top IS
    SIGNAL input_1_sync    : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL input_2_sync    : STD_LOGIC_VECTOR(2 DOWNTO 0);
	
    SIGNAL input_1_sig     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL input_2_sig     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL sum             : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL difference      : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    SIGNAL add_sync        : STD_LOGIC;
    SIGNAL subtractor_sync : STD_LOGIC;

    SIGNAL operator_sig    : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL result          : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL bcd_1_sig       : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL bcd_2_sig       : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL mux : STD_LOGIC;
	
BEGIN
	
    -- EXTEND THE INPUT SIGNALS TO 4 BITS
    input_1_sig <= '0' & input_1_sync;
    input_2_sig <= '0'  & input_2_sync;

    top_sync_input_1 : clock_synchronizer
	  GENERIC MAP (bit_width => 3)
	  PORT MAP (
		clk      => clk,
		reset    => reset,
		async_in => input_1_async,
		sync_out => input_1_sync
	);

    top_sync_input_2 : clock_synchronizer
	  GENERIC MAP (bit_width => 3)
	  PORT MAP (
		clk      => clk,
		reset    => reset,
		async_in => input_2_async,
		sync_out => input_2_sync
	);

    -- ADDER AND SUBTRACTOR INSTANTIATIONS
    top_adder : adder_beh
	  PORT MAP (
		input_1   => input_1_sig,
		input_2   => input_2_sig,
		cin       => '0',
		sum       => sum,
		cout      => OPEN
	);

    top_subtractor : subtractor_beh
	  PORT MAP (
		input_1   => input_1_sig,
		input_2   => input_2_sig,
		cin       => '0',
		difference => difference,
		cout      => OPEN
	);

    top_edge_add : rising_edge_synchronizer
	  PORT MAP (
	    clk => clk,
		reset => reset,
		input => add_async,
		edge => add_sync
	);

    top_edge_subtractor : rising_edge_synchronizer
	  PORT MAP (
	    clk => clk,
		reset => reset,
		input => subtractor_async,
		edge => subtractor_sync
	);
	
	
    -- PROCESS TO SELECT OPERATION (ADD OR SUBTRACT)
    PROCESS(clk, reset)
    BEGIN
	  IF (reset = '1') THEN
		mux <= '1';
	  ELSIF RISING_EDGE(clk) THEN
	    IF (add_sync = '1') THEN
		  mux <= '1';
		ELSIF (subtractor_sync = '1') THEN
		  mux <= '0';
		END IF;
	  END IF;
    END PROCESS;
	
	PROCESS(mux,sum,difference)
	BEGIN
	  IF mux = '1' THEN
	    operator_sig <= sum;
	  ELSE operator_sig <= difference;
	  END IF;
	END PROCESS;

    result <= operator_sig;

    -- SEVEN SEGMENT DISPLAY INSTANTIATIONS
    top_seven_seg1 : seven_seg
	  PORT MAP (
		bcd    => input_1_sig,
		HEX    => HEX4
	);

    top_seven_seg2 : seven_seg
	  PORT MAP (
		bcd    => input_2_sig,
		HEX    => HEX2
	);

    top_seven_seg3 : seven_seg
	  PORT MAP (
		bcd    => result,
		HEX    => HEX0
	);
		
END ARCHITECTURE arch;
