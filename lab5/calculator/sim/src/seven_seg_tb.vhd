library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.seven_seg_pkg.ALL;
USE work.clock_synchronizer_pkg.ALL;
USE work.adder_beh_pkg.ALL;
USE work.subtractor_beh_pkg.ALL;
USE work.top_pkg.ALL;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is
    constant period : time := 50 ns;
    
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL clk : STD_LOGIC := '0';
    
    SIGNAL input_1_async : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
    SIGNAL input_2_async : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
    
    SIGNAL add_async : STD_LOGIC := '1'; -- Async adder
    SIGNAL subtractor_async : STD_LOGIC := '1'; -- Async subtractor
    
    SIGNAL HEX0: STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL HEX2: STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL HEX4: STD_LOGIC_VECTOR(6 DOWNTO 0);
begin

    -- Component instantiation
    uut: top
        port map(
            clk => clk,
            reset => reset,
            input_1_async => input_1_async,
            input_2_async => input_2_async,
            add_async => add_async,-- Convert to STD_LOGIC_VECTOR(0 DOWNTO 0)
            subtractor_async => subtractor_async, -- Convert to STD_LOGIC_VECTOR(0 DOWNTO 0)
            HEX0 => HEX0,
            HEX2 => HEX2,
            HEX4 => HEX4
        );

    -- Clock generator process
    clk_gen: process
    begin
		clk <= not clk;
		wait for period / 2;
    end process;

    stim_proc: process
    begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
		
		wait for period;

        add_async <= '0';
		wait for period;
        add_async <= '1'; -- Enable addition

        for i in 0 to 7 loop
            for j in 0 to 7 loop
                input_1_async <= std_logic_vector(to_unsigned(i, 3));
                input_2_async <= std_logic_vector(to_unsigned(j, 3));
                wait for period;
            end loop;
        end loop;
		
		wait for period;
		
        subtractor_async <= '0';
		wait for period;
        subtractor_async <= '1'; -- Enable subtraction

        for i in 0 to 7 loop
            for j in 0 to 7 loop
                input_1_async <= std_logic_vector(to_unsigned(i, 3));
                input_2_async <= std_logic_vector(to_unsigned(j, 3));
                wait for period ;
            end loop;
        end loop;

        wait;
    end process;
end arch;
