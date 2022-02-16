
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;


entity comparison is
  Port (
    clk, reset      : in std_logic;
    compare_en      : in std_logic;
    compare_done    : in std_logic; 
    compare_out     : in std_logic_vector(16 downto 0); 
    
    compare_result  : out std_logic_vector(16 downto 0)

  );
end comparison;

architecture Behavioral of comparison is
    signal reg      : std_logic_vector(16 downto 0);
    signal reg_nxt  : std_logic_vector(16 downto 0);

begin

process (clk, reset)
begin
    if reset = '1' then 
        reg <= (others => '0');
    elsif (clk'event and clk = '1') then 
        reg <= reg_nxt;
    end if;         
end process;


end Behavioral;
