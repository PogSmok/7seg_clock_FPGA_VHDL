library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.types_pkg.all; -- seg_array_t

entity seg7_clock is
	port (
		clk       : in std_logic; -- 50 MHz input clock
		reset     : in std_logic;
		seg_out 	 : out seg_array_t -- 9 displays x 8 bits each HH:MM:SS:MMM (indexed from right to left)
	);
end entity;


architecture rtl of seg7_clock is
   signal clk_1kHz : std_logic;

	-- counters
	signal ms : integer range 0 to 999;
	signal s  : integer range 0 to 59;
	signal m  : integer range 0 to 59;
	signal h  : integer range 0 to 23;
	
	-- carries
	signal carry_ms : std_logic;
	signal carry_s  : std_logic;
	signal carry_m  : std_logic;
	
	-- singular digits
	signal h_tens, h_ones : integer range 0 to 9;
	signal m_tens, m_ones : integer range 0 to 9;
	signal s_tens, s_ones : integer range 0 to 9;
	signal ms_hundreds, ms_tens, ms_ones : integer range 0 to 9;
begin
	clk_div_inst : entity work.clock_divider
		port map (
			clk_in  => clk,
			clk_out => clk_1kHz
		);
		
	ms_counter_inst : entity work.counter_0_999
		port map (
			clk    => clk_1kHz,
			reset  => reset,
			enable => '1', -- always counting
			q      => ms,
			carry  => carry_ms
		);

	s_counter_inst : entity work.counter_0_59
		port map (
			clk    => clk_1kHz,
			reset  => reset,
			enable => carry_ms,
			q      => s,
			carry  => carry_s
		);

	m_counter_inst : entity work.counter_0_59
		port map (
			clk    => clk_1kHz,
			reset  => reset,
			enable => carry_s,
			q      => m,
			carry  => carry_m
		);

	h_counter_inst : entity work.counter_0_23
		port map (
			clk    => clk_1kHz,
			reset  => reset,
			enable => carry_m,
			q      => h,
			carry  => open
		);
		
	-- miliseconds
	ms_hundreds <= ms/100;
	ms_tens <= (ms / 10) mod 10;
	ms_ones <= ms mod 10;
	
	seg7_ms_hundreds_inst : entity work.seg7_decoder
		port map (digit => ms_hundreds, seg => seg_out(2));

	seg7_ms_tens_inst : entity work.seg7_decoder
		port map (digit => ms_tens, seg => seg_out(1));

	seg7_ms_ones_inst : entity work.seg7_decoder
		port map (digit => ms_ones, seg => seg_out(0));

	-- seconds
	s_tens <= s / 10;
	s_ones <= s mod 10;
	
	seg7_s_tens_inst : entity work.seg7_decoder
		port map (digit => s_tens, seg => seg_out(4));

	seg7_s_ones_inst : entity work.seg7_decoder
		port map (digit => s_ones, seg => seg_out(3));
		
	-- minutes
	m_tens <= m / 10;
	m_ones <= m mod 10;
	
	seg7_m_tens_inst : entity work.seg7_decoder
		port map (digit => m_tens, seg => seg_out(6));

	seg7_m_ones_inst : entity work.seg7_decoder
		port map (digit => m_ones, seg => seg_out(5));

	-- hours
	h_tens <= h / 10;
	h_ones <= h mod 10;
	
	seg7_h_tens_inst : entity work.seg7_decoder
		port map (digit => h_tens, seg => seg_out(8));

	seg7_h_ones_inst : entity work.seg7_decoder
		port map (digit => h_ones, seg => seg_out(7));
end rtl;