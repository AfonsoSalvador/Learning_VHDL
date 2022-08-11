library ieee;
use ieee.std_logic_1164.all;

entity top is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        led : out std_logic_vector (3 downto 0);
        sw: in std_logic_vector (7 downto 0)
    );
end top;

architecture arch of top is
    signal sel : std_logic_vector (1 downto 0);
    signal output_FF, output_inc, output_mux : std_logic_vector (3 downto 0);
    signal en : std_logic;
 
    begin

    led(3 downto 0) <= output_FF(3 downto 0);
    
    div_clk1: entity work.div_clk(Behavioral)
        port map(
            clk => clk,
            en => en
        );

    cod_prio1: entity work.cod_prio(cond_arch)
        port map(
            r => sw(7 downto 5),
            pcode => sel
        );

    mux3: entity work.mux_4x1(cond_arch)
        port map(
            i(0) => output_FF(3),
            i(1) => sw(4),
            i(2) => output_inc(3),
            i(3) => sw(3),
            s => output_mux(3),
            c => sel
        );

    mux2: entity work.mux_4x1(cond_arch)
        port map(
            i(0) => output_FF(2),
            i(1) => output_FF(3),
            i(2) => output_inc(2),
            i(3) => sw(2),
            s => output_mux(2),
            c => sel
        );

    mux1: entity work.mux_4x1(cond_arch)
        port map(
            i(0) => output_FF(1),
            i(1) => output_FF(2),
            i(2) => output_inc(1),
            i(3) => sw(1),
            s => output_mux(1),
            c => sel
        );    

    mux0: entity work.mux_4x1(cond_arch)
        port map(
            i(0) => output_FF(0),
            i(1) => output_FF(1),
            i(2) => output_inc(0),
            i(3) => sw(0),
            s => output_mux(0),
            c => sel
        );

    FF_D3: entity work.FF_D(Behavioral)
        port map(
            D => output_mux(3),
            Q => output_FF(3),
            e => en,
            clk => clk
        );

    FF_D2: entity work.FF_D(Behavioral)
        port map(
            D => output_mux(2),
            Q => output_FF(2),
            e => en,
            clk => clk
        );

    FF_D1: entity work.FF_D(Behavioral)
        port map(
            D => output_mux(1),
            Q => output_FF(1),
            e => en,
            clk => clk
        );

    FF_D0: entity work.FF_D(Behavioral)
        port map(
            D => output_mux(0),
            Q => output_FF(0),
            e => en,
            clk => clk
        );
    
    INC: entity work.inc_4bits(Behavioral)
        port map(
            inc_in => output_FF,
            inc_out => output_inc
        );

end arch;
