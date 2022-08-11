library ieee;
use ieee.std_logic_1164.all;

entity fsm is
   port(
      clk, reset : in  std_logic;
      ab : in std_logic_vector(1 downto 0);
      car_exit, car_enter: out std_logic
   );
end fsm;


-- Listing 5.2
architecture two_sensors_arch of fsm is
   type eg_state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
   signal state_reg, state_next : eg_state_type;
--   constant N : integer := 0; 
--   signal enable : std_logic;
--   signal divide_clk : integer range 0 to N;
   
begin
--    enable <= '1' when divide_clk = N else '0';
   
   -- state register
   process(clk, reset)
   begin
      if (reset = '1') then
         state_reg <= s0;
      elsif (clk'event and clk = '1') then
--        if (enable = '1') then
            state_reg <= state_next;
--        end if;
      end if;
      
      -- divisor de clock 
--      if (clk'event and clk='1') then
--          divide_clk <= divide_clk+1;
--           if divide_clk = N then
--                 divide_clk <= 0; -- reinicia contagem 
--            end if;
--        end if;
   end process;
   
   -- next-state/output logic
   process(state_reg, ab)
   
   begin
      state_next <= state_reg;          -- default back to same state
      car_exit   <= '0';                -- default 0
      car_enter  <= '0';                -- default 0
      
      case state_reg is
         when s0 =>
           
            if (ab = "10") then 
               state_next <= s1;
                
            elsif (ab = "01" or ab = "11") then 
               state_next <= s5;
         
            else 
               state_next <= s0;
            end if;            
            
         when s1 =>
            if (ab = "11") then 
               state_next <= s2;
         
            elsif (ab = "00"or ab = "01") then 
               state_next <= s0;
  
            else 
               state_next <= s1;

            end if;        

            
         when s2 =>
            if (ab = "01") then 
               state_next <= s3;

            elsif (ab = "10"or ab = "00") then 
               state_next <= s1;

            else 
               state_next <= s2;

            end if;             
            

         when s3 =>
            if (ab = "00" or ab = "10") then 
               state_next <= s4;

            elsif (ab = "11") then 
               state_next <= s2;

            else 
               state_next <= s3;

            end if;   
            

         when s4 =>
            car_enter <= '1';
            
            state_next <= s0;
         
            
         when s5 =>
            if (ab = "11") then 
               state_next <= s6;
   
            elsif (ab = "00" or ab = "10") then 
               state_next <= s0;

            else 
               state_next <= s5;

            end if;  
            
         when s6 =>
            if (ab = "10") then 
               state_next <= s7;

            elsif (ab = "01" or ab = "00") then 
               state_next <= s5;

            else 
               state_next <= s6;

            end if;  
         
         when s7 =>
            if (ab = "00" or ab = "01") then 
               state_next <= s8;

            elsif (ab = "11") then 
               state_next <= s6;

            else 
               state_next <= s7;

            end if;

         when s8 =>
            car_exit <= '1';
            
            state_next <= s0;

      end case;
   end process;
end two_sensors_arch;
