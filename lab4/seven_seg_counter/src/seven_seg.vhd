library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

PACKAGE seven_seg_pkg IS
  component seven_seg is
    port (
	enable          : in std_logic;
	bcd             : in std_logic_vector(3 downto 0);
	seven_seg_out   : out std_logic_vector(6 downto 0); -- seven segment display output
	seven_seg_out2  : out std_logic_vector(6 downto 0);
	seven_seg_out3  : out std_logic_vector(6 downto 0)
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
	seven_seg_out   : out std_logic_vector(6 downto 0); -- seven segment display output
	seven_seg_out2  : out std_logic_vector(6 downto 0);
	seven_seg_out3  : out std_logic_vector(6 downto 0)
  );  
end entity seven_seg;

architecture Behavioral of seven_seg is

SIGNAL output : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000"; -- seven segment display output signal

begin
  process(bcd)
  begin
    -- if enable = '1' then
	  case bcd is
	    when "0000" => output <= "1000000"; --0
		when "0001" => output <= "1111001"; --1
        when "0010" => output <= "0100100"; --2
        when "0011" => output <= "0110000"; --3
        when "0100" => output <= "0011001"; --4
        when "0101" => output <= "0010010"; --5
        when "0110" => output <= "0000010"; --6
        when "0111" => output <= "1111000"; --7
        when "1000" => output <= "0000000"; --8
        when "1001" => output <= "0011000"; --9
        when others => output <= "1111111";
      end case;
    -- end if;
  end process;
  seven_seg_out <= output;
  seven_seg_out2 <= output;
  seven_seg_out3 <= output;
end architecture Behavioral;
