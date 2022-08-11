
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port (
           clk : in STD_LOGIC;
           sseg: out STD_LOGIC_VECTOR (7 downto 0);
           an: out STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC
           );
end top;

architecture arch of top is
    signal in0,in1,in2,in3,in4,in5,in6,in7 :std_logic_vector (7 downto 0);
begin
    in0<="01111000";
    in1<="00000010";
    in2<="00010010";
    in3<="00011001";
    in4<="00110000";
    in5<="00100100";
    in6<="01111001";
    in7<="01000000";
    

    
   led_fsm : entity work.fsm_eg(two_seg_arch)
       port map(
            clk => clk,
            reset => '0',
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
