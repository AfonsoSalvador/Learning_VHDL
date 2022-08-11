-- Listing 5.1
library ieee;
use ieee.std_logic_1164.all;
entity sseg_fsm is
   port(
      clk, reset : in  std_logic;
      in3, in2, in1, in0 : in  std_logic_vector(7 downto 0);
      in7, in6, in5, in4 : in  std_logic_vector(7 downto 0);
      an, sseg     : out std_logic_vector(7 downto 0)
   );
end sseg_fsm;


-- Listing 5.2
architecture sseg_arch of sseg_fsm is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;
   constant N : integer := 3999; 
   signal enable : std_logic;
   signal divide_clk : integer range 0 to N;
   
begin
    enable <= '1' when divide_clk = N else '0';
   
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0;
      elsif (clk'event and clk = '1' and enable = '1') then
         state_reg <= state_next;
      end if;
      
      -- divisor de clock 
      if (clk'event and clk='1') then
          divide_clk <= divide_clk+1;
           if divide_clk = N then
                 divide_clk <= 0; -- reinicia contagem 
            end if;
        end if;
   end process;
   
   -- next-state/output logic
   process(state_reg,in3, in2, in1, in0, in7, in6, in5, in4)
   begin
      state_next <= state_reg;          -- default back to same state
      an         <= "00000000";                -- default 0
      sseg         <= "00000000";                -- default 0
      case state_reg is
         when s0 =>
            an<= "11111110";
            sseg <= in0;
            state_next <= s1;
            
         when s1 =>
            an<= "11111101";
            sseg <= in1;
            state_next <= s2;
            
         when s2 =>
            an<= "11111011";
            sseg <= in2;
            state_next <= s3;
            
         when s3 =>
            an<= "11110111";
            sseg <= in3;
            state_next <= s4;
            
         when s4 =>
            an<= "11101111";
            sseg <= in4;
            state_next <= s5;
            
         when s5 =>
            an<= "11011111";
            sseg <= in5;
            state_next <= s6;
            
         when s6 =>
            an<= "10111111";
            sseg <= in6;
            state_next <= s7;
         
         when s7 =>
            an<= "01111111";
            sseg <= in7;
            state_next <= s0;
      end case;
   end process;
end sseg_arch;
