
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top is
end tb_top;

architecture Behavioral of tb_top is

component top is
  Port (
        clki, reseti      : in std_logic; 
        start           : in std_logic;
        datainput       : in std_logic_vector(13 downto 0);
        dataOutput      : out std_logic_vector(18 downto 0);
        ld2mem          : out std_logic;
        ld2reg          : out std_logic
  
  
  );
end component;

    signal clk          : std_logic := '1';      
    signal reset        : std_logic;      
    signal start        : std_logic;
    signal datainput    : std_logic_vector(13 downto 0);
    signal dataOutput   : std_logic_vector(18 downto 0); 
    signal ld2mem       : std_logic;
    signal ld2reg       : std_logic;




    
    constant period1    : time := 5ns;

begin

dut: top
port map(
     clki          => clk,        
     reseti        => reset,      
     start        => start, 
     datainput    => datainput,
     dataOutput   => dataOutput,             
     ld2mem       => ld2mem,    
     ld2reg       => ld2reg        
);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1;


datainput <=    "00000000000000" after 0*period1,
                
                "00000010000001"  after 4 *period1, 
                "00000100000010"  after 6 *period1, 
                "00000110000011"  after 8 *period1,
                "00001000000100"  after 10*period1,
                "00001100000110"  after 12*period1,
                "00001110000111"  after 14*period1,
                "00010000001000"  after 16*period1,
                "00010010001001"  after 18*period1,
                "00010100001010"  after 20*period1,
                "00010110001011"  after 22*period1,
                "00011000001100"  after 24*period1,
                "00011010001101"  after 26*period1,
                "00011100001110"  after 28*period1,
                "00011110001111"  after 30*period1,
                "00100000010000"  after 32*period1,
                "00100010010001"  after 34*period1,
               
                
--                "00000010000001" after 6*period1,
--                "00000100000001" after 8*period1,
--                "00000100000001" after 10*period1,
--                "00000010000001" after 12*period1,
--                "00000100000001" after 14*period1,
--                "00000100000001" after 16*period1,
--                "00001000000011" after 18*period1,
--                "00001100000101" after 20*period1,
--                "00010000000111" after 22*period1,
--                "00010100001001" after 24*period1,
--                "00011000001011" after 26*period1,
--                "00011100001101" after 28*period1,
--                "00100000001111" after 30*period1,
--                "00100100010001" after 32*period1,
--                "00101000010011" after 34*period1,
--                "00101100010101" after 36*period1,
--                "00110000010111" after 38*period1,   
--                "00100000001111" after 40*period1,
--                "00100100010001" after 42*period1,




                "00000000000001" after 140*period1,
                "00000000000010" after 142*period1,
                "00000000000011" after 144*period1,
                "00000000000100" after 146*period1,
                "00000000000101" after 148*period1,
                "00000000000110" after 150*period1,
                "00000000000111" after 152*period1,
                "00000000001000" after 154*period1,
                "00000000001001" after 156*period1,
                "00000000001010" after 158*period1,
                "00000000001011" after 160*period1,
                "00000000001100" after 162*period1,
                "00000000001101" after 164*period1,
                "00000000001110" after 166*period1,
                "00000000001111" after 168*period1,
                "00000000010000" after 170*period1,
                "00000000010001" after 172*period1,
                "00000000010010" after 174*period1,
                "00000000010011" after 176*period1,
                "00000000010100" after 178*period1,
                "00000000010101" after 180*period1,                
                "00000000010110" after 182*period1,
                "00000000010111" after 184*period1,
                "00000000011000" after 186*period1,
                "00000000011001" after 188*period1,
                "00000000011010" after 190*period1,
                "00000000011011" after 192*period1,
                "00000000011100" after 194*period1,
                "00000000011101" after 196*period1,
                "00000000011110" after 198*period1,
                "00000000011111" after 200*period1,
                "00000000100000" after 202*period1;
                                       
start <= '0', 
         '1' after 220*period1,
         '0' after 222*period1;


end Behavioral;
