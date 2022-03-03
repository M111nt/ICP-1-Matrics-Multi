
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_comparison is
end tb_comparison;

architecture Behavioral of tb_comparison is

component comparison is
  Port (
    clk             : in std_logic;
    reset           : in std_logic;
    max_en          : in std_logic;
    --compare_done    : in std_logic; 
    compare_out     : in std_logic_vector(18 downto 0); 
    
    compare_result  : out std_logic_vector(18 downto 0)

  );
end component;

    signal clk            : std_logic := '1';
    signal reset          : std_logic;                    
    signal max_en         : std_logic;                    
    --signal compare_done   : std_logic;                    
    signal compare_out    : std_logic_vector(18 downto 0);            
    signal compare_result : std_logic_vector(18 downto 0);

    constant period1    : time := 5ns;

begin
dut: comparison 
port map(
        clk             =>  clk,          
        reset           =>  reset,         
        
        max_en          =>  max_en,        
        --compare_done    =>  compare_done, 
        compare_out     =>  compare_out,   
        compare_result  =>  compare_result
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1; 
--compare_done <= '0', 
--                '1' after 10*period1,
--                '0' after 12*period1,
--                '1' after 20*period1,         
--                '0' after 22*period1;
                
                
max_en <=   '0', 
            '1' after 24*period1, 
            '0' after 26*period1;
            
compare_out <= "0000000000000000000", 
               "0000000000000000010" after 8*period1, 
               "0000000000000000001" after 16*period1;            
                
         
         
         
         
         
         
end Behavioral;
