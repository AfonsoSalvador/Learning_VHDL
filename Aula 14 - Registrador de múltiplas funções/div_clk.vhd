library ieee;
use ieee.std_logic_1164.all;

entity div_clk is
    Port ( 
        clk : in std_logic;
        en : out std_logic
    );
end div_clk;

architecture Behavioral of div_clk is
    constant N : integer := 49999999; 
    signal divide_clk : integer range 0 to N;

    begin
        process (clk)
            begin
                if (clk'event and clk='1') then
                    divide_clk <= divide_clk+1;
                if divide_clk = N then
                    divide_clk <= 0;
                end if;
                end if;
        end process;
 
    en <= '1' when divide_clk = N else '0';

end Behavioral;
