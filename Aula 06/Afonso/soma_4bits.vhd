library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity soma_4bits is
    port (
           a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           c_in : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s : out STD_LOGIC_VECTOR (3 downto 0));
end soma_4bits;

architecture soma_4 of soma_4bits is
    signal c,soma : std_logic_vector(3 downto 0);
    
begin
    soma1 : entity work.soma_1bit(soma_1)
        port map(
            c_in => c_in,
            b => b(0),
            a => a(0),
            c_out => c(0),
            s => soma(0)
         );
        
      soma2 : entity work.soma_1bit(soma_1)
             port map(
                 c_in => c(0),
                 b => b(1),
                 a => a(1),
                 c_out => c(1),
                 s => soma(1)
              );

        
      soma3 : entity work.soma_1bit(soma_1)
             port map(
                 c_in => c(1),
                 b => b(2),
                 a => a(2),
                 c_out => c(2),
                 s => soma(2)
              );       

       
      soma4 : entity work.soma_1bit(soma_1)
             port map(
                 c_in => c(2),
                 b => b(3),
                 a => a(3),
                 c_out => c(3),
                 s => soma(3)
              ); 
              
       
       c_out <= (not(b(3)) and not(a(3)) and soma(3)) or (b(3) and a(3) and not(soma(3)));
       
       s<=soma;      
                       
end soma_4;
