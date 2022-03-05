
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_controller is
end tb_controller;

architecture Behavioral of tb_controller is

component controller is
    Port ( 
        clk, reset      : in std_logic;
        ldcoeff_done    : in std_logic;
        ldinput_done    : in std_logic; 
        start           : in std_logic; 
        load_done       : in std_logic; 
        op_done         : in std_logic;
        store_done      : in std_logic;
    --ld coeff--------------------------------------------------------------       
        ctrl_coeff      : in std_logic_vector(5 downto 0);
        coeff           : in std_logic_vector(6 downto 0);
    --ld input--------------------------------------------------------------
        ctrl_input      : in std_logic_vector(3 downto 0);
        input           : in std_logic_vector(7 downto 0);
    --number from op---------------------------------------------------------    
        --out_ready       : in std_logic; --return 4 results to controller
        result1         : in std_logic_vector(18 downto 0);
        result2         : in std_logic_vector(18 downto 0);
        result3         : in std_logic_vector(18 downto 0);
        result4         : in std_logic_vector(18 downto 0);    
        
------------------------------------------------------------------------        
        
        ldcoeff_enable  : out std_logic;
        ldinput_enable  : out std_logic; 
        load_en         : out std_logic;
        op_en           : out std_logic;
        store_en        : out std_logic; 
        --ready           : out std_logic; 
        max_en          : out std_logic;
        avg_en          : out std_logic;   


        data2op         : out std_logic_vector(7 downto 0);
        address2op      : out std_logic_vector(5 downto 0);
    ----------------------------------------------------------------
        result1_2store  : out std_logic_vector(18 downto 0);
        result2_2store  : out std_logic_vector(18 downto 0);
        result3_2store  : out std_logic_vector(18 downto 0);
        result4_2store  : out std_logic_vector(18 downto 0)  
    );

end component;

        signal clk             : std_logic := '1'; 
        signal reset           : std_logic;
        signal ldcoeff_done    : std_logic;
        signal ldinput_done    : std_logic; 
        signal start           : std_logic; 
        signal load_done       : std_logic; 
        signal op_done         : std_logic;
        signal store_done      : std_logic;  
        signal ctrl_coeff      : std_logic_vector(5 downto 0);
        signal coeff           : std_logic_vector(6 downto 0);
        signal ctrl_input      : std_logic_vector(3 downto 0);
        signal input           : std_logic_vector(7 downto 0);   
        --signal out_ready       : std_logic; --return 4 results to controller
        signal result1         : std_logic_vector(18 downto 0);
        signal result2         : std_logic_vector(18 downto 0);
        signal result3         : std_logic_vector(18 downto 0);
        signal result4         : std_logic_vector(18 downto 0);    
        
      
        
        signal ldcoeff_enable  : std_logic;
        signal ldinput_enable  : std_logic; 
        signal load_en         : std_logic;
        signal op_en           : std_logic;
        signal store_en        : std_logic; 
        --signal ready           : std_logic; 
        signal max_en          : std_logic;
        signal avg_en          : std_logic;   
        signal data2op         : std_logic_vector(7 downto 0);
        signal address2op      : std_logic_vector(5 downto 0);
        signal result1_2store  : std_logic_vector(18 downto 0);
        signal result2_2store  : std_logic_vector(18 downto 0);
        signal result3_2store  : std_logic_vector(18 downto 0);
        signal result4_2store  : std_logic_vector(18 downto 0);  

        constant period1    : time := 5ns;


begin

dut: controller 
port map(
           clk           => clk,         
           reset         => reset,       
           ldcoeff_done  => ldcoeff_done,
           ldinput_done  => ldinput_done,
           start         => start,       
           load_done     => load_done,   
           op_done       => op_done,     
           store_done    => store_done,  
           ctrl_coeff    => ctrl_coeff,  
           coeff         => coeff,       
           ctrl_input    => ctrl_input,  
           input         => input,       
           --out_ready     => out_ready,   
           result1       => result1,     
           result2       => result2,     
           result3       => result3 ,    
           result4       => result4,
           
           ldcoeff_enable => ldcoeff_enable,
           ldinput_enable => ldinput_enable,
           load_en        => load_en,       
           op_en          => op_en,         
           store_en       => store_en,      
           --ready          => ready,         
           max_en         => max_en,        
           avg_en         => avg_en,        
           data2op        => data2op,       
           address2op     => address2op,    
           result1_2store => result1_2store,
           result2_2store => result2_2store,
           result3_2store => result3_2store,
           result4_2store => result4_2store
);


clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1; 
      
ldcoeff_done <= '0', 
                '1' after 74*period1, 
                '0' after 76*period1;
                

ctrl_coeff <= "000000",
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
              "100000" after 74*period1;

 
coeff <= "0000000",
         "0000001" after 12*period1,
         "0000010" after 14*period1,
         "0000011" after 16*period1,
         "0000100" after 18*period1,
         "0000101" after 20*period1,
         "0000110" after 22*period1,
         "0000111" after 24*period1,
         "0001000" after 26*period1,
         "0001001" after 28*period1,
         "0001010" after 30*period1,
         "0001011" after 32*period1,
         "0001100" after 34*period1,
         "0001101" after 36*period1,
         "0001110" after 38*period1,
         "0001111" after 40*period1,
         "0010000" after 42*period1,
         "0010001" after 44*period1,
         "0010010" after 46*period1,
         "0010011" after 48*period1,
         "0010100" after 50*period1,
         "0010101" after 52*period1,                
         "0010110" after 54*period1,
         "0010111" after 56*period1,
         "0011000" after 58*period1,
         "0011001" after 60*period1,
         "0011010" after 62*period1,
         "0011011" after 64*period1,
         "0011100" after 66*period1,
         "0011101" after 68*period1,
         "0011110" after 70*period1,
         "0011111" after 72*period1,
         "0100000" after 74*period1;

ldinput_done <= '0', 
                '1' after 78*period1, 
                '0' after 80*period1;

start <= '0', 
         '1' after 84*period1, 
         '0' after 86*period1;


ctrl_input <= "0000",
              "0001" after 88*period1,
              "0010" after 90*period1,
              "0011" after 92*period1,
              "0100" after 94*period1,
              "0101" after 96*period1,
              "0110" after 98*period1,
              "0111" after 100*period1,
              "1000" after 102*period1;
 
input <=  "00000000",
          "00000001" after 88*period1, 
          "00000010" after 90*period1, 
          "00000011" after 92*period1, 
          "00000100" after 94*period1, 
          "00000101" after 96*period1, 
          "00000110" after 98*period1, 
          "00000111" after 100*period1,
          "00001000" after 102*period1;



      
load_done <= '0', 
             '1' after 102*period1, 
             '0' after 104*period1; 
op_done <= '0', 
           '1' after 110*period1, 
           '0' after 112*period1;
                
store_done <= '0', 
              '1' after 120*period1,
              '0' after 122*period1;  
      
       

result1 <= "0000000000000000001";    
result2 <= "0000000000000000010";   
result3 <= "0000000000000000011";    
result4 <= "0000000000000000100";    



end Behavioral;
