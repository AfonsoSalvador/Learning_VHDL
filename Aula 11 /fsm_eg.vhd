library ieee;
use ieee.std_logic_1164.all;

entity fsm_eg is
   port(
      clk, reset, en, cw : in  std_logic;
      in3, in2, in1, in0 : in  std_logic_vector(7 downto 0);
      in7, in6, in5, in4 : in  std_logic_vector(7 downto 0);
      an, sseg     : out std_logic_vector(7 downto 0)
   );
end fsm_eg;


-- Listing 5.2
architecture two_seg_arch of fsm_eg is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
   signal state_reg, state_next : eg_state_type;
   constant N : integer := 9999999; 
   signal enable : std_logic;
   signal divide_clk : integer range 0 to N;
   
begin
    enable <= '1' when divide_clk = N else '0';
   
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s3;
      elsif (clk'event and clk = '1') then
        if (enable = '1') then
            state_reg <= state_next;
        end if;
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
   process(state_reg,in3, in2, in1, in0, in7, in6, in5, in4,en,cw)
   
   begin
      state_next <= state_reg;          -- default back to same state
      an         <= "00000000";                -- default 0
      sseg         <= "00000000";                -- default 0
      
      case state_reg is
         when s0 =>
            an<= "11111110";
            sseg <= in0;
           
            if (en='0') then 
                state_next <= s0;
                
            elsif (cw='1' and en='1') then 
                state_next <= s1;
         
             else 
                state_next <= s7;
            end if;            
            
         when s1 =>
            an<= "11111101";
            sseg <= in1;
            
             if (en='0') then 
                state_next <= s1;
                           
             elsif (cw='1' and en='1') then 
                 state_next <= s2;
                    
             else 
                 state_next <= s0;  
             end if;         

            
         when s2 =>
            an<= "11111011";
            sseg <= in2;
            
            if (en='0') then 
               state_next <= s2;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s3;
                   
            else 
                state_next <= s1;   
            end if;             
            
         when s3 =>
            an<= "11110111";
            sseg <= in3;

            if (en='0') then 
               state_next <= s3;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s4;
                   
            else 
                state_next <= s2;   
            end if; 
            
         when s4 =>
            an<= "11110111";
            sseg <= in4;
           
            if (en='0') then 
               state_next <= s4;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s5;
                   
            else 
                state_next <= s3;   
            end if; 
            
         when s5 =>
            an<= "11111011";
            sseg <= in5;

            if (en='0') then 
               state_next <= s5;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s6;
                   
            else 
                state_next <= s4;   
            end if; 
            
         when s6 =>
            an<= "11111101";
            sseg <= in6;

            if (en='0') then 
               state_next <= s6;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s7;
                   
            else 
                state_next <= s5;   
            end if; 
         
         when s7 =>
            an<= "11111110";
            sseg <= in7;

            if (en='0') then 
               state_next <= s7;
                          
            elsif (cw='1' and en='1') then 
                state_next <= s0;
                   
            else 
                state_next <= s6;   
            end if; 
      end case;
   end process;
end two_seg_arch;
