library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
           clk : in STD_LOGIC;
           sseg: out STD_LOGIC_VECTOR (7 downto 0);
           an: out STD_LOGIC_VECTOR (7 downto 0);
           sw: in std_logic_vector (0 downto 0);
           btn: in std_logic_vector (3 downto 1)
      );
end top;

architecture arch of top is
    signal in0,in1,in2,in3,in4,in5,in6,in7 :std_logic_vector (7 downto 0);
    signal ab,car_inout : std_logic_vector (1 downto 0);
    signal count :std_logic_vector (31 downto 0);
    signal m7, m6, m5, m4, m3, m2, m1, m0: std_logic;
    signal i7, i6, i5, i4, i3, i2, i1, i0: std_logic; 
    
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
     
     mod_counter0: entity work.mod_m_counter(arch)
        port map(
            clk => clk,
            reset => '0',
            inc => car_inout(1),
            dec => car_inout(0),
            inc_m => i1, 
            max_tick => m0, 
            min_tick => i0, 
            q => count(3 downto 0)
        ); 
     
     mod_counter1: entity work.mod_m_counter(arch)
           port map(
               clk => clk,
               reset => '0',
               inc => m0,
               dec => i0,
               inc_m => i2, 
               max_tick => m1, 
               min_tick => i1, 
               q => count(7 downto 4)
        ); 
        
     mod_counter2: entity work.mod_m_counter(arch)
           port map(
               clk => clk,
               reset => '0',
               inc => m1,
               dec => i1,
               inc_m => i3, 
               max_tick => m2, 
               min_tick => i2, 
               q => count(11 downto 8)
           ); 
        
     mod_counter3: entity work.mod_m_counter(arch)
              port map(
                  clk => clk,
                  reset => '0',
                  inc => m2,
                  dec => i2,
                  inc_m => i4, 
                  max_tick => m3, 
                  min_tick => i3, 
                  q => count(15 downto 12)
           );      

     mod_counter4: entity work.mod_m_counter(arch)
        port map(
            clk => clk,
            reset => '0',
            inc => m3,
            dec => i3,
            inc_m => i5, 
            max_tick => m4, 
            min_tick => i4, 
            q => count(19 downto 16)
        ); 
     
     mod_counter5: entity work.mod_m_counter(arch)
           port map(
               clk => clk,
               reset => '0',
               inc => m4,
               dec => i4,
               inc_m => i6, 
               max_tick => m5, 
               min_tick => i5, 
               q => count(23 downto 20)
        ); 
        
     mod_counter6: entity work.mod_m_counter(arch)
           port map(
               clk => clk,
               reset => '0',
               inc => m5,
               dec => i5,
               inc_m => i7, 
               max_tick => m6, 
               min_tick => i6, 
               q => count(27 downto 24)
           ); 
        
     mod_counter7: entity work.mod_m_counter(arch)
              port map(
                  clk => clk,
                  reset => '0',
                  inc => m6,
                  dec => i6,
                  inc_m => i0, 
                  max_tick => m7, 
                  min_tick => i7, 
                  q => count(31 downto 28)
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
