library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package types_pkg is
    type seg_array_t is array (8 downto 0) of std_logic_vector(7 downto 0); -- 9 displays x 8 bits each HH:MM:SS:MMM (indexed from right to left)
end package;