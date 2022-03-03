
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_operation is
end tb_operation;

architecture Behavioral of tb_operation is

component operation is
  Port (
        clk, reset      : in std_logic;
        
        --begin_coeff2op  : in std_logic;
        op_en           : in std_logic;
        --flag_data2op    : in std_logic;
        data2op         : in std_logic_vector(7 downto 0);
        address2op      : in std_logic_vector(5 downto 0);
 ---------------------------------------------------------------- 
        -- to the controller--------------------------------------
        --data2op_done    : out std_logic; 
        
        op_done         : out std_logic;
        
        out_ready       : out std_logic;
        result1         : out std_logic_vector(18 downto 0);
        result2         : out std_logic_vector(18 downto 0);
        result3         : out std_logic_vector(18 downto 0);
        result4         : out std_logic_vector(18 downto 0);

        --to the compare---------------------------------------------
        compare_done    : out std_logic;
        compare_out     : out std_logic_vector(18 downto 0)
          
  );
end component;

    signal clk          : std_logic := '1';      
    signal reset        : std_logic;
    signal op_en        : std_logic;      
    --signal flag_data2op : std_logic;    
    signal data2op      : std_logic_vector(7 downto 0);
    signal address2op   : std_logic_vector(5 downto 0);
    
    --signal data2op_done : std_logic; 
    signal op_done      : std_logic;
    signal out_ready    : std_logic;
    signal result1      : std_logic_vector(18 downto 0);
    signal result2      : std_logic_vector(18 downto 0);
    signal result3      : std_logic_vector(18 downto 0);
    signal result4      : std_logic_vector(18 downto 0);
    
    signal compare_done : std_logic;
    signal compare_out  : std_logic_vector(18 downto 0);
    
    

    
    constant period1    : time := 5ns;


begin

dut: operation
port map(
    clk             => clk,        
    reset           => reset,
    op_en           => op_en,      
    --flag_data2op    => flag_data2op,
    data2op         => data2op,     
    address2op      => address2op,  

    --data2op_done    => data2op_done,
    op_done         => op_done,     
    out_ready       => out_ready,   
    result1         => result1,     
    result2         => result2,     
    result3         => result3,     
    result4         => result4,     

    compare_done    => compare_done,
    compare_out     => compare_out    
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1; 
op_en <= '0', 
         '1' after 8*period1, 
         '0' after 148*period1;
         
--flag_data2op <= '0', 
--                '1' after 8*period1;

data2op <=      "00000000" after 0*period1,
                "00000001" after 12*period1,
                "00000010" after 14*period1,
                "00000011" after 16*period1,
                "00000100" after 18*period1,
                "00000101" after 20*period1,
                "00000110" after 22*period1,
                "00000111" after 24*period1,
                "00001000" after 26*period1,
                "00001001" after 28*period1,
                "00001010" after 30*period1,
                "00001011" after 32*period1,
                "00001100" after 34*period1,
                "00001101" after 36*period1,
                "00001110" after 38*period1,
                "00001111" after 40*period1,
                "00010000" after 42*period1,
                "00010001" after 44*period1,
                "00010010" after 46*period1,
                "00010011" after 48*period1,
                "00010100" after 50*period1,
                "00010101" after 52*period1,                
                "00010110" after 54*period1,
                "00010111" after 56*period1,
                "00011000" after 58*period1,
                "00011001" after 60*period1,
                "00011010" after 62*period1,
                "00011011" after 64*period1,
                "00011100" after 66*period1,
                "00011101" after 68*period1,
                "00011110" after 70*period1,
                "00011111" after 72*period1,
                "00100000" after 74*period1,
                
                "00000001" after 76*period1, 
                "00000010" after 78*period1,
                "00000011" after 80*period1,
                "00000100" after 82*period1,
                "00000101" after 84*period1,
                "00000110" after 86*period1,
                "00000111" after 88*period1,
                "00001000" after 90*period1;               
                
address2op <= "000000" after 0*period1,
              "000001" after 12*period1,
              "000010" after 14*period1,
              "000011" after 16*period1,
              "000100" after 18*period1,
              "000101" after 20*period1,
              "000110" after 22*period1,
              "000111" after 24*period1,
              "001000" after 26*period1,
              "001001" after 28*period1,
              "001010" after 30*period1,
              "001011" after 32*period1,
              "001100" after 34*period1,
              "001101" after 36*period1,
              "001110" after 38*period1,
              "001111" after 40*period1,
              "010000" after 42*period1,
              "010001" after 44*period1,
              "010010" after 46*period1,
              "010011" after 48*period1,
              "010100" after 50*period1,
              "010101" after 52*period1,
              "010110" after 54*period1,
              "010111" after 56*period1,
              "011000" after 58*period1,
              "011001" after 60*period1,
              "011010" after 62*period1,
              "011011" after 64*period1,
              "011100" after 66*period1,
              "011101" after 68*period1,
              "011110" after 70*period1,
              "011111" after 72*period1,
              "100000" after 74*period1,

              "100001" after 76*period1,
              "100010" after 78*period1,
              "100011" after 80*period1,
              "100100" after 82*period1,
              "100101" after 84*period1,
              "100110" after 86*period1,
              "100111" after 88*period1,
              "101000" after 90*period1;

end Behavioral;
