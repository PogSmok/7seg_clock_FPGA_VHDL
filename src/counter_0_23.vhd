library ieee;
use ieee.std_logic_1164.all;

entity counter_0_23 is
	port (
	  clk     : in std_logic;
	  reset   : in std_logic;
	  enable  : in std_logic; -- increment the counter
	  q       : out integer range 0 to 23; -- value of the counter
	  carry   : out std_logic -- overflow flag
	);
end entity;

architecture rtl of counter_0_23 is
	signal counter   : integer range 0 to 23 := 0;
	signal carry_int : std_logic := '0'; -- internal carry
begin 
	process(clk, reset)
	begin
	   if reset = '1' then -- asynchronous reset
			counter <= 0;
			carry_int <= '0';
		elsif rising_edge(clk) then
			carry_int <= '0'; -- no carry by default
			if enable = '1' then
				if counter = 23 then
					counter <= 0;
					carry_int <= '1';
				else 
					counter <= counter+1;
				end if;
			end if;
		end if;
	end process;
	
	q <= counter;
	carry <= carry_int;
end rtl;