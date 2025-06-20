library ieee;
use ieee.std_logic_1164.all;

use work.types_pkg.all; -- seg_array_t

entity tb_seg7_clock is
end entity;

architecture sim of tb_seg7_clock is
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal seg_out   : seg_array_t;

    constant clk_period : time := 20 ns; -- 50 MHz
begin
	-- Clock generation
	clk_process : process
	begin
	   while true loop
			clk <= '0';
			wait for clk_period / 2;
			clk <= '1';
			wait for clk_period / 2;
		end loop;
	end process;

	uut: entity work.seg7_clock
		port map (
			clk     => clk,
			reset   => reset,
			seg_out => seg_out
		);

end architecture;