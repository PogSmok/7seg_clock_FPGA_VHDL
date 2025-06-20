library ieee;
use ieee.std_logic_1164.all;

entity seg7_decoder is
	port (
		digit : in integer range 0 to 9; -- number to display
		seg   : out std_logic_vector(7 downto 0) -- 7 segment bits (active LOW)
	);
end entity;

architecture rtl of seg7_decoder is 
begin 
	process(digit)
	begin
		case digit is
			when 0 => seg <= "00000011";
			when 1 => seg <= "10011111";
			when 2 => seg <= "00100101";
			when 3 => seg <= "00001101";
			when 4 => seg <= "10011001";
			when 5 => seg <= "01001001";
			when 6 => seg <= "01000001";
			when 7 => seg <= "00011111";
			when 8 => seg <= "00000001";
			when 9 => seg <= "00001001";
			when others => seg <= "11111111"; -- turn display off
		end case;
	end process;
end rtl;
	