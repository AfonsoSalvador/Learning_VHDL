
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
           clk : in STD_LOGIC;
           sseg: out STD_LOGIC_VECTOR (7 downto 0);
           an: out STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           sw: in std_logic_vector (2 downto 0)
           );
end top;

architecture arch of top is
    signal in0,in1,in2,in3,in4,in5,in6,in7 :std_logic_vector (7 downto 0);
 
begin
    in0<="10011100";
    in1<="10011100";
    in2<="10011100";
    in3<="10011100";
    in4<="10100011";
    in5<="10100011";
    in6<="10100011";
    in7<="10100011";
    
   led_fsm : entity work.fsm_eg(two_seg_arch)
       port map(
            en => sw(0),
            cw => sw(1),
            clk => clk,
            reset => sw(2),
            in0 => in0,
            in1 => in1,
            in2 => in2,
            in3 => in3,
            in4 => in4,
            in5 => in5,
            in6 => in6,
            in7 => in7,
            an => an,
            sseg => sseg
        );
    
end arch;
