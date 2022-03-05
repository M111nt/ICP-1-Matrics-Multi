
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_store is
end tb_store;

architecture Behavioral of tb_store is

component store_result is
  Port (
        clk             : in std_logic;
        reset           : in std_logic;
        store_en        : in std_logic;
        result1_2store  : in std_logic_vector(18 downto 0);
        result2_2store  : in std_logic_vector(18 downto 0);
        result3_2store  : in std_logic_vector(18 downto 0);
        result4_2store  : in std_logic_vector(18 downto 0);
        store_done      : out std_logic;
        address_out     : out std_logic_vector(7 downto 0);
        result_out      : out std_logic_vector(18 downto 0)
  );
end component;

        signal clk             : std_logic := '1';
        signal reset           : std_logic;
        signal store_en        : std_logic;
        signal result1_2store  : std_logic_vector(18 downto 0);
        signal result2_2store  : std_logic_vector(18 downto 0);
        signal result3_2store  : std_logic_vector(18 downto 0);
        signal result4_2store  : std_logic_vector(18 downto 0);
        signal store_done      : std_logic;
        signal address_out     : std_logic_vector(7 downto 0);
        signal result_out      : std_logic_vector(18 downto 0);

        constant period1    : time := 5ns;

begin

dut: store_result
port map(
            clk            => clk,           
            reset          => reset,         
            store_en       => store_en,      
            result1_2store => result1_2store,
            result2_2store => result2_2store,
            result3_2store => result3_2store,
            result4_2store => result4_2store,
            store_done     => store_done,    
            address_out    => address_out,       
            result_out     => result_out    

);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1; 
store_en <= '0', 
            '1' after 6*period1,
            '0' after 8*period1;
result1_2store <= "0000000000000000001";
result2_2store <= "0000000000000000010";
result3_2store <= "0000000000000000011";
result4_2store <= "0000000000000000100";






end Behavioral;




