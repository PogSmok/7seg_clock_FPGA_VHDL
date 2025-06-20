library ieee;
use ieee.std_logic_1164.all;

entity clock_divider is
	port (
		clk_in  : in std_logic; -- 50MHz clock signal
		clk_out : out std_logic -- 1KHz clock signal (for miliseconds)
	);
end entity;

architecture rtl of clock_divider is 
	constant DIV     : integer := 25000; -- Half-period count for 1kHz: 50_000_000/1_000/2
	signal counter   : integer range 0 to DIV := 0;
	signal clk_state : std_logic := '1';
begin
	process(clk_in)
	begin
		if rising_edge(clk_in) then
			if counter = DIV-1 then
				counter <= 0;
				clk_state <= not clk_state;
			else 
				counter <= counter+1;
			end if;
		end if;
	end process;
	
	clk_out <= clk_state;
end rtl;