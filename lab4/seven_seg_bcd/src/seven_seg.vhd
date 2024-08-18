library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE seven_seg_pkg IS
  component seven_seg is
    port (
      enable          : in std_logic;
      bcd             : in std_logic_vector(3 downto 0);
      seven_seg_out   : out std_logic_vector(6 downto 0) -- seven segment display output
    );  
  end component seven_seg;
END PACKAGE seven_seg_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is
  port (
    enable          : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0) -- seven segment display output
  );  
end entity seven_seg;

architecture Behavioral of seven_seg is
begin
  process(bcd, enable)
  begin
    if enable = '1' then
      case bcd is
        when "0000" => seven_seg_out <= "1000000"; --0
        when "0001" => seven_seg_out <= "1111001"; --1
        when "0010" => seven_seg_out <= "0100100"; --2
        when "0011" => seven_seg_out <= "0110000"; --3
        when "0100" => seven_seg_out <= "0011001"; --4
        when "0101" => seven_seg_out <= "0010010"; --5
        when "0110" => seven_seg_out <= "0000010"; --6
        when "0111" => seven_seg_out <= "1111000"; --7
        when "1000" => seven_seg_out <= "0000000"; --8
        when "1001" => seven_seg_out <= "0011000"; --9
        when others => seven_seg_out <= "1111111";
      end case;
    else
      seven_seg_out <= "1111111";
    end if;
  end process;
end architecture Behavioral;
