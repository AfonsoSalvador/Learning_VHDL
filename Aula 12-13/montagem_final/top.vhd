library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
           clk : in STD_LOGIC;
           sseg: out STD_LOGIC_VECTOR (7 downto 0);
           an: out STD_LOGIC_VECTOR (7 downto 0);
           sw: in std_logic_vector (0 downto 0);
           btn: in std_logic_vector (3 downto 1);
           led : out std_logic_vector(7 downto 0)
      );
end top;

architecture arch of top is
    signal in0,in1,in2,in3,in4,in5,in6,in7 :std_logic_vector (7 downto 0);
    signal ab,car_inout : std_logic_vector (1 downto 0);
    signal count :std_logic_vector (31 downto 0);

begin
   
    sensor_fsm : entity work.fsm(two_sensors_arch)
        port map(
            clk => clk,
            reset => sw(0),
            ab => ab,
            car_exit => car_inout(0),
            car_enter => car_inout(1)
        );

    db_unit : entity work.db_fsm(arch)
        port map(
           clk   => clk,
           reset => '0',
           sw    => btn(3),
           db    => ab(1)
        );

    db_unit1 : entity work.db_fsm(arch)
        port map(
           clk   => clk,
           reset => '0',
           sw    => btn(1),
           db    => ab(0)
        );
        
     bin_counter1 : entity work.bin_counter(arch)
        port map(
            clk => clk, 
            inc => car_inout(1), 
            dec => car_inout(0),
            q => count
        );
        
     hex_to_sseg8 : entity work.hex_to_sseg(arch)
        port map(
            hex => count(31 downto 28),
            dp => '1',
            sseg => in7
        );
        
      hex_to_sseg7 : entity work.hex_to_sseg(arch)
           port map(
                hex => count(27 downto 24),
                dp => '1',
                sseg => in6
            );
       hex_to_sseg6 : entity work.hex_to_sseg(arch)
        port map(
             hex => count(23 downto 20),
             dp => '1',
             sseg => in5
       );
       
    hex_to_sseg5 : entity work.hex_to_sseg(arch)
         port map(
             hex => count(19 downto 16),
             dp => '1',
                    sseg => in4
              );
    hex_to_sseg4 : entity work.hex_to_sseg(arch)
         port map(
                           hex => count(15 downto 12),
                           dp => '1',
                           sseg => in3
                     );
                     
   hex_to_sseg3 : entity work.hex_to_sseg(arch)
          port map(
            hex => count(11 downto 8),
            dp => '1',
            sseg => in2
        );
   hex_to_sseg2 : entity work.hex_to_sseg(arch)
                              port map(
                                   hex => count(7 downto 4),
                                   dp => '1',
                                   sseg => in1
                             );
   hex_to_sseg1 : entity work.hex_to_sseg(arch)
       port map(
             hex => count(3 downto 0),
             dp => '1',
             sseg => in0
      );
      
     sseg_fsm1: entity work.sseg_fsm(sseg_arch)
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
