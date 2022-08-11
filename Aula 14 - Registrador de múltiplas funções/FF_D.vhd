library ieee;
use ieee.std_logic_1164.all;

entity FF_D is
   Port ( 
      D : in std_logic;
      e : in std_logic;
      Q : out std_logic;
      clk : in std_logic
   );
end FF_D;

architecture Behavioral of FF_D is

   begin
   
      process(clk,e)
         begin
            if (clk'event and clk='1') then
            if (e='1') then
               Q <= D;
            end if;
            end if;
      end process;

end Behavioral;
