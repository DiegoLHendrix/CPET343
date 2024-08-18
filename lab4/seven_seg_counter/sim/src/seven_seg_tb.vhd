library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY work;
USE work.seven_seg_pkg.ALL;
USE work.generic_counter_pkg.ALL;
USE work.generic_adder_pkg.ALL;
USE work.generic_sum_register_pkg.ALL;
USE work.top_pkg.ALL;

entity seven_seg_tb is
end seven_seg_tb;

architecture arch of seven_seg_tb is
    constant period : time := 20 ns;
    signal enable : std_logic := '0';
    signal bcd : std_logic_vector(3 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal ssd_out : std_logic_vector(6 downto 0) := (others => '0'); -- Seven Segment Display output
begin

    -- Clock generator process
    clk_gen: process
    begin
        while now < 1000 ns loop
            clk <= not clk;
            wait for period / 2;
        end loop;
        wait;
    end process;

    -- BCD iteration
    sequential_tb : process 
    begin
        report "****************** Sequential testbench start ****************";
        wait for 80 ns;   -- Let all the initial conditions trickle through
        for i in 0 to 15 loop
            bcd <= std_logic_vector(unsigned(bcd) + 1 );
            wait for 40 ns;
        end loop;
        report "****************** Sequential testbench stop ****************";
        wait;
    end process; 

    -- Enable process
    enable_proc: process
    begin
        wait for 2 * period;
        enable <= '1';
        wait;
    end process; 

    -- Component instantiation
    uut: top
        generic map( 
            bits => 4,
            max => 3
        )   
        port map(
            CLOCK_50 => clk,
            HEX0 => ssd_out,
            HEX2 => ssd_out,
            HEX4 => ssd_out
        );
end arch;
