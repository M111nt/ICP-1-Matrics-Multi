
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_load_coeff is
end tb_load_coeff;

architecture Behavioral of tb_load_coeff is

component load_coeff is
  Port (
     clk, reset     : in std_logic;
    
    --signal from controller to load_coeff----------------------------------
    ldcoeff_enable         : in std_logic;
    --coeff from memory-----------------------------------------------------
    coeff_read        : in std_logic_vector(13 downto 0);
    
    
    --enable txt file to memory---------------------------------------------
    ld2mem          : out std_logic;
    --to memory-------------------------------------------------------------
    --address         : out std_logic_vector(3 downto 0);
    --to controller---------------------------------------------------------
    ctrl_coeff      : out std_logic_vector(5 downto 0);
    coeff           : out std_logic_vector(6 downto 0);
    ldcoeff_done    : out std_logic
  
  
  );
end component;

    signal clk      : std_logic := '1';      
    signal reset    : std_logic;      
    signal ldcoeff_enable  : std_logic;    
    signal coeff_read : std_logic_vector(13 downto 0);  
    signal ld2mem   : std_logic;  
    --signal address  : std_logic_vector(3 downto 0);   
    signal ctrl_coeff  : std_logic_vector(5 downto 0);
    signal coeff       : std_logic_vector(6 downto 0);
    signal ldcoeff_done: std_logic;
    
    constant period1         : time := 5ns;

begin

dut: load_coeff
port map(
    clk             => clk,        
    reset           => reset,      
    ldcoeff_enable         => ldcoeff_enable,      
    coeff_read        => coeff_read,     
    ld2mem          => ld2mem,       
    --address         => address,      
    ctrl_coeff      => ctrl_coeff,   
    coeff           => coeff,        
    ldcoeff_done    => ldcoeff_done
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1;

ldcoeff_enable <=  --'0' after  0*period1,
            '1' ,--after  10*period1,
            '0' after  90*period1;

coeff_read <=   "00000000000000" after 0*period1,
                
                "00000010000001" after 12*period1,
                "00000100000010" after 14*period1,
                "00000110000011" after 16*period1,
                "00001000000100" after 18*period1,--4
                "00001100000110" after 20*period1,--6
                "00001110000111" after 22*period1,
                "00010000001000" after 24*period1,
                "00010010001001" after 26*period1,
                "00010100001010" after 28*period1,
                "00010110001011" after 30*period1,
                "00011000001100" after 32*period1,
                "00011010001101" after 34*period1,
                "00011100001110" after 36*period1,
                "00011110001111" after 38*period1,   
                "00100000010000" after 40*period1,
                "00100010010001" after 42*period1; --17
                --"00101000010011" after 44*period1;
                --"00101100010101" after 46*period1;
                                        




end Behavioral;
