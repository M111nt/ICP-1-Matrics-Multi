
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_load_input is
end tb_load_input;

architecture Behavioral of tb_load_input is

component load_input is
  Port (
        clk, reset      : in std_logic; 
        
        --from controller-------------------------------------
        ldinput_en      : in std_logic;
        column          : in std_logic_vector(1 downto 0);
        --from read input-------------------------------------
        input_in        : in std_logic_vector(7 downto 0);
        
        --to read input---------------------------------------
        ld2reg          : out std_logic;        
        --to controller---------------------------------------
        ctrl_input      : out std_logic_vector(3 downto 0);
        input           : out std_logic_vector(7 downto 0);
        ldinput_done    : out std_logic
  
  
  );
end component;

    signal clk          : std_logic := '1';      
    signal reset        : std_logic;      
    signal ldinput_en   : std_logic;    
    signal column       : std_logic_vector(1 downto 0);
    
    signal input_in     : std_logic_vector(7 downto 0);  
    signal ld2reg       : std_logic;  
    
    
    signal ctrl_input   : std_logic_vector(3 downto 0);
    signal input        : std_logic_vector(7 downto 0);
    signal ldinput_done : std_logic;
    
    constant period1    : time := 5ns;

begin

dut: load_input
port map(
    clk             => clk,        
    reset           => reset,      
    ldinput_en      => ldinput_en,    
    column          => column,                 
    input_in        => input_in,      
    ld2reg          => ld2reg,        
    ctrl_input      => ctrl_input,  
    input           => input,       
    ldinput_done    => ldinput_done
    
    
    
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1;

ldinput_en <=  '0' after  0*period1,
            '1' after  10*period1,
            '0' after  80*period1;
column <=   "00" after 0*period1, 
            "01" after 100*period1;



input_in <=     "00000000" after 0*period1,

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
                "00100000" after 74*period1;
                --"00000001" after 76*period1;
--                 after 78*period1,
--                 after 80*period1,
--                 after 82*period1,
--                 after 84*period1,
--                 after 86*period1,
--                 after 88*period1,
--                 after 90*period1,
--                 after 92*period1,
--                 after 94*period1,
--                 after 96*period1,
--                 after 98*period1,
--                 after 100*period1,
--                 after 102*period1,
--                 after 104*period1,
--                 after 106*period1,
--                 after 108*period1;


end Behavioral;
