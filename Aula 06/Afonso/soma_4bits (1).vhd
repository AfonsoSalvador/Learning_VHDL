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

-- utiliza 4x a entidade do somador de 1 bit, para construir um de 4 bits
architecture soma_4 of soma_4bits is
    signal c,soma : std_logic_vector(3 downto 0);
    
begin
    -- aplica o somador de 1 bit no primeiro bit do input
    soma1 : entity work.soma_1bit(soma_1)
        port map(
            c_in => c_in,
            b => b(0),
            a => a(0),
            -- armazena o primeiro "vai 1" (c_out) dentro do vetor c
            c_out => c(0),
            -- armazena a soma no primeiro bit do vetor soma (soma(0)) 
            s => soma(0)
         );
     -- repete o mesmo processo de "soma", desta vez utilizando c(0) como c_in 
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
              
       -- o cálculo do overflow foi colocado em c_out 
       c_out <= (not(b(3)) and not(a(3)) and soma(3)) or (b(3) and a(3) and not(soma(3)));
       
       -- retorna a soma para 's'
       s<=soma;      
       
                       
end soma_4;
