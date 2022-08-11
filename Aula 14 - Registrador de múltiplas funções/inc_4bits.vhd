library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity inc_4bits is
    Port ( 
        inc_in : in std_logic_vector (3 downto 0);
        inc_out : out std_logic_vector (3 downto 0)
    );
end inc_4bits;

architecture Behavioral of inc_4bits is
begin
    inc_out  <= std_logic_vector(unsigned(inc_in)+1);
end Behavioral;
