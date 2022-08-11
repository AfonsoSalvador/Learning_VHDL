
library ieee;
use ieee.std_logic_1164.all;

entity top is
   port(
      sw  : in  std_logic_vector(15 downto 0); -- 16 switches
      led : out std_logic_vector(15 downto 0) -- 16 LEDs
   );
end top;

architecture struc_arch of top is
    signal c : std_logic_vector (1 downto 0); -- vetor logico para salvar o direcionamento dos MUXs
begin
   
     
   
     prio_encoder42 : entity work.prio_encoder42(cond_arch)
        port map(
           r => sw(15 downto 12),--coleta a entrada do codificador de prioridade
           code => c             --retorna um vetor logico de selecao, armazena em c
      );
      
      led(15 downto 12) <= sw(15 downto 12); --acende os LEDs correspondentes aos switches de selecao
      led(4 downto 0) <= sw(4 downto 0);     --acende os LEDs correspondentes aos switches de input para shift
      
      mux0 : entity work.mux4(cond_arch) -- MUX para o bit 0, acende o LED7 |espaco para output|
            port map(
                 a=>sw(1 downto 1),
                 b=>sw(0 downto 0),
                 c=>sw(2 downto 2),
                 d=>sw(2 downto 2),
                 s=>c,
                 x=>led(7 downto 7)
            );
      
      mux1 : entity work.mux4(cond_arch) -- MUX para o bit 1, acede o LED8 |espaco para output|
            port map(
                 a=>sw(2 downto 2),
                 b=>sw(1 downto 1),
                 c=>sw(3 downto 3),
                 d=>sw(3 downto 3),
                 s=>c,
                 x=>led(8 downto 8)
            );
      
      mux2 : entity work.mux4(cond_arch) -- MUX para o bit 2, acede o LED8 |espaco para output|
      port map(
           a=>sw(3 downto 3),
           b=>sw(2 downto 2),
           c=>sw(1 downto 1),
           d=>sw(4 downto 4),
           s=>c,
           x=>led(9 downto 9)
      );
      
      
      
end struc_arch;
