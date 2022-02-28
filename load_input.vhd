
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
use std.textio.all;


entity load_input is
  Port (
        clk, reset      : in std_logic; 
        
        --from controller-------------------------------------
        ldinput_enable  : in std_logic;
        --from read input-------------------------------------
        input_in        : in std_logic_vector(7 downto 0);
        
        --to read input---------------------------------------
        ld2reg          : out std_logic;        
        --to controller---------------------------------------
        ctrl_input      : out std_logic_vector(3 downto 0);
        input           : out std_logic_vector(7 downto 0);
        ldinput_done    : out std_logic

  );
end load_input;

architecture Behavioral of load_input is

    type state_type is (s_initial, s_keep, s_send);
    signal state_reg, state_nxt : state_type;
    
    signal counter      : std_logic_vector(4 downto 0);
    signal counter_nxt  : std_logic_vector(4 downto 0);
    
    signal input01      : std_logic_vector(7 downto 0);
    signal input02      : std_logic_vector(7 downto 0);
    signal input03      : std_logic_vector(7 downto 0);
    signal input04      : std_logic_vector(7 downto 0);
    signal input05      : std_logic_vector(7 downto 0);
    signal input06      : std_logic_vector(7 downto 0);
    signal input07      : std_logic_vector(7 downto 0);
    signal input08      : std_logic_vector(7 downto 0);
    signal input09      : std_logic_vector(7 downto 0);
    signal input10      : std_logic_vector(7 downto 0);
    signal input11      : std_logic_vector(7 downto 0);
    signal input12      : std_logic_vector(7 downto 0);
    signal input13      : std_logic_vector(7 downto 0);
    signal input14      : std_logic_vector(7 downto 0);
    signal input15      : std_logic_vector(7 downto 0);
    signal input16      : std_logic_vector(7 downto 0);
    signal input17      : std_logic_vector(7 downto 0);
    signal input18      : std_logic_vector(7 downto 0);
    signal input19      : std_logic_vector(7 downto 0);
    signal input20      : std_logic_vector(7 downto 0);
    signal input21      : std_logic_vector(7 downto 0);
    signal input22      : std_logic_vector(7 downto 0);
    signal input23      : std_logic_vector(7 downto 0);
    signal input24      : std_logic_vector(7 downto 0);
    signal input25      : std_logic_vector(7 downto 0);
    signal input26      : std_logic_vector(7 downto 0);
    signal input27      : std_logic_vector(7 downto 0);
    signal input28      : std_logic_vector(7 downto 0);
    signal input29      : std_logic_vector(7 downto 0);
    signal input30      : std_logic_vector(7 downto 0);
    signal input31      : std_logic_vector(7 downto 0);
    signal input32      : std_logic_vector(7 downto 0);    
    
      
    
begin
    
process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        counter <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        counter <= counter_nxt;
    end if;         
end process;    

process(state_reg, s_initial, s_keep, s_send)
begin 
    case state_reg is 
        when s_initial => 
            ctrl_input <= (others => '0');  
            input <= (others => '0');     
            ldinput_done <= '0';
            if ldinput_enable = '1' then 
                state_nxt <= s_keep;         
            else
                state_nxt <= s_initial;         
            end if;
            
        when s_keep => 
            case counter is 
                when "00000" =>
                when "00001" =>
                when "00010" =>
                when "00011" =>
                when "00100" =>
                when "00101" =>
                when "00110" =>
                when "00111" =>
                when "01000" =>
                when "01001" =>
                when "01010" =>
                when "01011" =>
                when "01100" =>
                when "01101" =>
                when "01110" =>
                when "01111" =>
                when "10000" =>
                when "10001" =>
                when "10010" =>
                when "10011" =>
                when "10100" =>
                when "10101" =>
                when "10110" =>
                when "10111" =>
                when "11000" =>
                when "11001" =>
                when "11010" =>
                when "11011" =>
                when "11100" =>
                when "11101" =>
                when "11110" =>
                when "11111" =>
                
    
                
                
                
                
                
                
            end case;
            
        when s_send => 
            
        
    end case;





end process;




end Behavioral;
