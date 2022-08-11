
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1_1bit is
    Port ( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC);
end mux2_1_1bit;

architecture cond_arch of mux2_1_1bit is
begin
   y <= i0 when sel = '0' else
	     i1;
end cond_arch;

