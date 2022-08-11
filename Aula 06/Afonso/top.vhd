library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port ( 
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0)
     );
           
end top;

architecture somador_completo of top is

    --Criação de sinais adicionais para facilitar a 
    --visualização de informação dentro do código
    signal c_in, sub, overflow : std_logic;
    signal a, b, bs, not_b, s : std_logic_vector(3 downto 0);
    
begin
    --Atribuindo valores condizentes a seus respectivos sinais
    --além de acender o led correspondente de cada switch
    a <= sw(15 downto 12);
    led(15 downto 12) <= a;
    
    b <= sw(10 downto 7);
    led(10 downto 7) <= b;
    not_b <= not b;
    
    sub <= sw(11);
    led(11) <= sub;
   
    led(3 downto 0) <= s;
    
    led(4) <= overflow; 
   
   --MUX de seleção entre Soma/Subtração
    mux_0 : entity work.mux2_1_1bit(cond_arch)
        port map(
             i0 => b,
             i1 => not_b,
             sel => sub,
             y => bs
        );
    --Soma de valores após sua modificação (ou não modificação) no MUX anterior
    soma : entity work.soma_4bits(soma_4)
        port map(
            a => a,
            b => bs,
            c_in => sub,
            c_out => overflow, 
            s => s
        ); 
    
end somador_completo;
