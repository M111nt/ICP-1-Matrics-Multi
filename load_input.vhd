
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
use std.textio.all;


entity load_input is
  Port (
        clk, reset      : in std_logic; 
        
        --from controller-------------------------------------
        ldinput_en      : in std_logic;
        column          : in std_logic_vector(1 downto 0);
        
        load_en         : in std_logic;
        
        --from read input-------------------------------------
        input_in        : in std_logic_vector(7 downto 0);
        
        --to read input---------------------------------------
        ld2reg          : out std_logic;        
        --to controller---------------------------------------
        ctrl_input      : out std_logic_vector(3 downto 0);
        input           : out std_logic_vector(7 downto 0);
        
        ldinput_done    : out std_logic;
        load_done       : out std_logic

  );
end load_input;

architecture Behavioral of load_input is

    type state_type is (s_initial, s_keep, s_send);
    signal state_reg, state_nxt : state_type;
    
    signal counter      : std_logic_vector(4 downto 0);
    signal counter_nxt  : std_logic_vector(4 downto 0);
    
    signal send_ctrl    : std_logic_vector(2 downto 0) := (others => '0');
    signal send_ctrl_nxt: std_logic_vector(2 downto 0) := (others => '0');
    --signal row          : std_logic_vector(1 downto 0);
    --signal row_nxt      : std_logic_vector(1 downto 0);
    
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
    signal input_test   : std_logic_vector(7 downto 0); 
    
      
    
begin
    
process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        counter <= (others => '0');
        send_ctrl <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        counter <= counter_nxt;
        send_ctrl <= send_ctrl_nxt;
    end if;         
end process;    

process(state_reg, ldinput_en, counter, column, send_ctrl, load_en,
        input01, input02, input03, input04, input05, input06, input07, input08, input09, input10, 
        input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, 
        input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, 
        input31, input32
       
        ) 
begin 
    case state_reg is 
        when s_initial => 
            ld2reg <= '0';
            ctrl_input <= (others => '0');  
            input <= (others => '0');     
            ldinput_done <= '0';
            load_done <= '0';
            counter_nxt <= (others => '0');
            send_ctrl_nxt <= (others => '0');
            if ldinput_en = '1' then 
                state_nxt <= s_keep;         
            else
                state_nxt <= s_initial;         
            end if;
            
        when s_keep => 
            ld2reg <= '1';
            case counter is 
                when "00000" => input01 <= input_in; counter_nxt <= "00001"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00001" => input02 <= input_in; counter_nxt <= "00010"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00010" => input03 <= input_in; counter_nxt <= "00011"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00011" => input04 <= input_in; counter_nxt <= "00100"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00100" => input05 <= input_in; counter_nxt <= "00101"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00101" => input06 <= input_in; counter_nxt <= "00110"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00110" => input07 <= input_in; counter_nxt <= "00111"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "00111" => input08 <= input_in; counter_nxt <= "01000"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01000" => input09 <= input_in; counter_nxt <= "01001"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01001" => input10 <= input_in; counter_nxt <= "01010"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01010" => input11 <= input_in; counter_nxt <= "01011"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01011" => input12 <= input_in; counter_nxt <= "01100"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01100" => input13 <= input_in; counter_nxt <= "01101"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01101" => input14 <= input_in; counter_nxt <= "01110"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01110" => input15 <= input_in; counter_nxt <= "01111"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "01111" => input16 <= input_in; counter_nxt <= "10000"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10000" => input17 <= input_in; counter_nxt <= "10001"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10001" => input18 <= input_in; counter_nxt <= "10010"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10010" => input19 <= input_in; counter_nxt <= "10011"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10011" => input20 <= input_in; counter_nxt <= "10100"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10100" => input21 <= input_in; counter_nxt <= "10101"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10101" => input22 <= input_in; counter_nxt <= "10110"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10110" => input23 <= input_in; counter_nxt <= "10111"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "10111" => input24 <= input_in; counter_nxt <= "11000"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11000" => input25 <= input_in; counter_nxt <= "11001"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11001" => input26 <= input_in; counter_nxt <= "11010"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11010" => input27 <= input_in; counter_nxt <= "11011"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11011" => input28 <= input_in; counter_nxt <= "11100"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11100" => input29 <= input_in; counter_nxt <= "11101"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11101" => input30 <= input_in; counter_nxt <= "11110"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11110" => input31 <= input_in; counter_nxt <= "11111"; ldinput_done <= '0';--state_nxt <= s_keep; 
                when "11111" => input32 <= input_in; counter_nxt <= "00000"; ldinput_done <= '1';--state_nxt <= s_keep; 
                when others => input_test <= input_in; ldinput_done <= '0';--state_nxt <= s_keep;
            end case;
            if load_en = '1' then 
                state_nxt <= s_send; 
            else 
                state_nxt <= s_keep;
            end if;
            
        when s_send => 
            ld2reg <= '0';
            
            case column is 
                when "00" =>
                    state_nxt <= s_send;
                    case send_ctrl is 
                        when "000" => ctrl_input <= "0001"; input <= input01; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "001" => ctrl_input <= "0010"; input <= input02; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "010" => ctrl_input <= "0011"; input <= input03; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "011" => ctrl_input <= "0100"; input <= input04; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "100" => ctrl_input <= "0101"; input <= input05; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "101" => ctrl_input <= "0110"; input <= input06; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "110" => ctrl_input <= "0111"; input <= input07; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "111" => ctrl_input <= "1000"; input <= input08; load_done <= '1'; send_ctrl_nxt <= (others => '0');
                        when others => ctrl_input <= "0001"; input <= input01; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                    end case;                  
                
                when "01" => 
                    state_nxt <= s_send;
                    case send_ctrl is 
                        when "000" => ctrl_input <= "0001"; input <= input09; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "001" => ctrl_input <= "0010"; input <= input10; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "010" => ctrl_input <= "0011"; input <= input11; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "011" => ctrl_input <= "0100"; input <= input12; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "100" => ctrl_input <= "0101"; input <= input13; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "101" => ctrl_input <= "0110"; input <= input14; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "110" => ctrl_input <= "0111"; input <= input15; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "111" => ctrl_input <= "1000"; input <= input16; load_done <= '1'; send_ctrl_nxt <= (others => '0');
                        when others => ctrl_input <= "0001"; input <= input09; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                    end case;
                    
                when "10" => 
                    state_nxt <= s_send;
                    case send_ctrl is 
                        when "000" => ctrl_input <= "0001"; input <= input17; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "001" => ctrl_input <= "0010"; input <= input18; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "010" => ctrl_input <= "0011"; input <= input19; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "011" => ctrl_input <= "0100"; input <= input20; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "100" => ctrl_input <= "0101"; input <= input21; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "101" => ctrl_input <= "0110"; input <= input22; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "110" => ctrl_input <= "0111"; input <= input23; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "111" => ctrl_input <= "1000"; input <= input24; load_done <= '1'; send_ctrl_nxt <= (others => '0');
                        when others => ctrl_input <= "0001"; input <= input17; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                    end case;
                    
                    
                when "11" => 
                    --state_nxt <= s_send;
                    case send_ctrl is 
                        when "000" => ctrl_input <= "0001"; input <= input25; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "001" => ctrl_input <= "0010"; input <= input26; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "010" => ctrl_input <= "0011"; input <= input27; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "011" => ctrl_input <= "0100"; input <= input28; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "100" => ctrl_input <= "0101"; input <= input29; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "101" => ctrl_input <= "0110"; input <= input30; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "110" => ctrl_input <= "0111"; input <= input31; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "111" => ctrl_input <= "1000"; input <= input32; load_done <= '1'; send_ctrl_nxt <= (others => '0'); state_nxt <= s_initial; --at the end of a matrics and jump to the begining 
                        when others => ctrl_input <= "0001"; input <= input25; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                    end case;
                
                when others => 
                    state_nxt <= s_send;
            end case;
        
    end case;


end process;




end Behavioral;
