
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_load_coeff is
end tb_load_coeff;

architecture Behavioral of tb_load_coeff is

component load_coeff is
  Port (
     clk, reset     : in std_logic;
    
    --signal from controller to load_coeff----------------------------------
    load_en         : in std_logic;
    --coeff from memory-----------------------------------------------------
    coeff_in        : in std_logic_vector(31 downto 0);
    
    
    --enable txt file to memory---------------------------------------------
    ld2mem          : out std_logic;
    --to memory-------------------------------------------------------------
    address         : out std_logic_vector(3 downto 0);
    --to controller---------------------------------------------------------
    ctrl_coeff      : out std_logic_vector(5 downto 0);
    coeff           : out std_logic_vector(6 downto 0);
    ldcoeff_done    : out std_logic
  
  
  );
end component;

    signal clk      : std_logic := '1';      
    signal reset    : std_logic;      
    signal load_en  : std_logic;    
    signal coeff_in : std_logic_vector(31 downto 0);  
    signal ld2mem   : std_logic;  
    signal address  : std_logic_vector(3 downto 0);   
    signal ctrl_coeff  : std_logic_vector(5 downto 0);
    signal coeff       : std_logic_vector(6 downto 0);
    signal ldcoeff_done: std_logic;
    
    constant period1         : time := 5ns;

begin

dut: load_coeff
port map(
    clk             => clk,        
    reset           => reset,      
    load_en         => load_en,      
    coeff_in        => coeff_in,     
    ld2mem          => ld2mem,       
    address         => address,      
    ctrl_coeff      => ctrl_coeff,   
    coeff           => coeff,        
    ldcoeff_done    => ldcoeff_done
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1;

load_en <=  '0' after  0*period1,
            '1' after  10*period1,
            '0' after  80*period1;

coeff_in <=     "00000000000000000000000000000000" after 0*period1,
                "00000000000000000000000100000001" after 46*period1,
                "00000000000000000000000100000001" after 48*period1,
                "00000000000000000000001000000011" after 50*period1,
                "00000000000000000000001100000101" after 52*period1,
                "00000000000000000000010000000111" after 54*period1,
                "00000000000000000000010100001001" after 56*period1,
                "00000000000000000000011000001011" after 58*period1,
                "00000000000000000000011100001101" after 60*period1,
                "00000000000000000000100000001111" after 62*period1,
                "00000000000000000000100100010001" after 64*period1,
                "00000000000000000000101000010011" after 66*period1,
                "00000000000000000000101100010101" after 68*period1,
                "00000000000000000000110000010111" after 70*period1,   
                "00000000000000000000100000001111" after 72*period1,
                "00000000000000000000100100010001" after 74*period1,
                "00000000000000000000101000010011" after 76*period1,
                "00000000000000000000101100010101" after 78*period1;





end Behavioral;
