
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity soma_1bit is
    port ( 
           a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s : out STD_LOGIC);
end soma_1bit;

architecture soma_1 of soma_1bit is

begin

    c_out <= (b and c_in) or (a and c_in) or (a and b);
    s <= a xor b xor c_in;
    
end soma_1;

