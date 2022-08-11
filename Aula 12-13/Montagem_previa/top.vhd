
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
           clk : in STD_LOGIC;
           sseg: out STD_LOGIC_VECTOR (7 downto 0);
           an: out STD_LOGIC_VECTOR (7 downto 0);
           reset : in STD_LOGIC;
           sw: in std_logic_vector (0 downto 0)
           btn: in std_logic_vector (1 downt 0)
           );
end top;

architecture arch of top is
    signal in0,in1,in2,in3,in4,in5,in6,in7,in8,in9 :std_logic_vector (7 downto 0);
    signal ab,car_inout : std_logic_vector (1 downto 0);

begin
    in0<="11000000";
    in1<="11111001";
    in2<="10100100";
    in3<="10110000";
    in4<="10011001";
    in5<="10010010";
    in6<="10000010";
    in7<="11111000";
    in8<="10000000";
    in9<="10010000";
    
    sensor_fsm : entity work.fsm(two_sensors_arch)
    port map(
        clk => clk,
        reset => sw(0),
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

    db_unit : entity work.db_fsm(arch)
    port map(
       clk   => clk,
       reset => '0',
       sw    => btn(0),
       db    => ab(0)
    );

    db_unit : entity work.db_fsm(arch)
    port map(
       clk   => clk,
       reset => '0',
       sw    => btn(1),
       db    => ab(1)
    );
    
end arch;
