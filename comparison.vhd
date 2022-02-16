
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;


entity comparison is
  Port (
    clk, reset      : in std_logic;
    max_en          : in std_logic;
    compare_done    : in std_logic; 
    compare_out     : in std_logic_vector(16 downto 0); 
    
    compare_result  : out std_logic_vector(16 downto 0)

  );
end comparison;

architecture Behavioral of comparison is
    signal reg      : std_logic_vector(16 downto 0) := (others => '0');
    signal reg_nxt  : std_logic_vector(16 downto 0) := (others => '0');

    type state_type is (s_compare, s_send);
    signal state_reg, state_nxt : state_type;

begin

process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_compare;
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt;
    end if;         
end process;

state_machine: process (state_reg, s_compare, s_send, reg)
begin 
    case state_reg is 
        when s_compare =>
            if max_en = '1' then 
                state_nxt <= s_send;
            else 
                state_nxt <= s_compare;
            end if;
            
        when s_send => 
           compare_result <= reg; 
           state_nxt <= s_compare; 
    end case;
end process;

--------------------------------------------------------------------------

process (clk, reset)
begin
    if reset = '1' then 
        reg <= (others => '0');
    elsif (clk'event and clk = '1') then 
        reg <= reg_nxt;
    end if;         
end process;

compare: process (compare_done, reg, reg_nxt, compare_out)
begin
if compare_done = '1' then --receive data from op, iteration 4 times.
    reg_nxt <= compare_out; 
    if reg < reg_nxt then
        reg_nxt <= compare_out;
    else 
        reg_nxt <= reg;
    end if;
else 
    reg_nxt <= reg;
end if;



end process;




end Behavioral;
