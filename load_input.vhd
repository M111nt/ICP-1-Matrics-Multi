
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
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

component ff is
  generic(N:integer:=1);
  port(   D  :  in std_logic_vector(N-1 downto 0);
          Q  : out std_logic_vector(N-1 downto 0);
        clk  :  in std_logic;
        reset:  in std_logic
      );
end component;

    type state_type is (s_initial, s_keep, s_send);
    signal state_reg, state_nxt : state_type;
    
    signal counter      : std_logic_vector(5 downto 0);
    signal counter_nxt  : std_logic_vector(5 downto 0);
    
    signal send_ctrl    : unsigned(4 downto 0) := (others => '0');
    signal send_ctrl_nxt: unsigned(4 downto 0) := (others => '0');
    
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
    
    signal input01_nxt  : std_logic_vector(7 downto 0);
    signal input02_nxt  : std_logic_vector(7 downto 0);
    signal input03_nxt  : std_logic_vector(7 downto 0);
    signal input04_nxt  : std_logic_vector(7 downto 0);
    signal input05_nxt  : std_logic_vector(7 downto 0);
    signal input06_nxt  : std_logic_vector(7 downto 0);
    signal input07_nxt  : std_logic_vector(7 downto 0);
    signal input08_nxt  : std_logic_vector(7 downto 0);
    signal input09_nxt  : std_logic_vector(7 downto 0);
    signal input10_nxt  : std_logic_vector(7 downto 0);
    signal input11_nxt  : std_logic_vector(7 downto 0);
    signal input12_nxt  : std_logic_vector(7 downto 0);
    signal input13_nxt  : std_logic_vector(7 downto 0);
    signal input14_nxt  : std_logic_vector(7 downto 0);
    signal input15_nxt  : std_logic_vector(7 downto 0);
    signal input16_nxt  : std_logic_vector(7 downto 0);
    signal input17_nxt  : std_logic_vector(7 downto 0);
    signal input18_nxt  : std_logic_vector(7 downto 0);
    signal input19_nxt  : std_logic_vector(7 downto 0);
    signal input20_nxt  : std_logic_vector(7 downto 0);
    signal input21_nxt  : std_logic_vector(7 downto 0);
    signal input22_nxt  : std_logic_vector(7 downto 0);
    signal input23_nxt  : std_logic_vector(7 downto 0);
    signal input24_nxt  : std_logic_vector(7 downto 0);
    signal input25_nxt  : std_logic_vector(7 downto 0);
    signal input26_nxt  : std_logic_vector(7 downto 0);
    signal input27_nxt  : std_logic_vector(7 downto 0);
    signal input28_nxt  : std_logic_vector(7 downto 0);
    signal input29_nxt  : std_logic_vector(7 downto 0);
    signal input30_nxt  : std_logic_vector(7 downto 0);
    signal input31_nxt  : std_logic_vector(7 downto 0);
    signal input32_nxt  : std_logic_vector(7 downto 0);  
      
    
begin
    
process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        send_ctrl <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        send_ctrl <= send_ctrl_nxt;
    end if;         
end process;    

process(state_reg, ldinput_en, counter, column, send_ctrl, load_en) 
begin 
            load_done <= '0';
            ctrl_input <= (others => '0');
            input <= (others => '0');
            counter_nxt <= counter;
            send_ctrl_nxt <= send_ctrl;

    case state_reg is 
        when s_initial => 
            ld2reg <= '0';
            ctrl_input <= (others => '0');  
            input <= (others => '0');     
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
            counter_nxt <= counter + 1;
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
                        when "00000" => ctrl_input <= "0001"; input <= input01; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00001" => ctrl_input <= "0010"; input <= input02; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00010" => ctrl_input <= "0011"; input <= input03; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00011" => ctrl_input <= "0100"; input <= input04; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00100" => ctrl_input <= "0101"; input <= input05; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00101" => ctrl_input <= "0110"; input <= input06; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00110" => ctrl_input <= "0111"; input <= input07; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "00111" => ctrl_input <= "1000"; input <= input08; load_done <= '1'; send_ctrl_nxt <= "01000";
                        when others => load_done <= '0'; send_ctrl_nxt <= send_ctrl;
                    end case;                  
                
                when "01" => 
                    state_nxt <= s_send;
                    case send_ctrl is 
                        when "01000" => ctrl_input <= "0001"; input <= input09; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01001" => ctrl_input <= "0010"; input <= input10; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01010" => ctrl_input <= "0011"; input <= input11; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01011" => ctrl_input <= "0100"; input <= input12; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01100" => ctrl_input <= "0101"; input <= input13; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01101" => ctrl_input <= "0110"; input <= input14; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01110" => ctrl_input <= "0111"; input <= input15; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "01111" => ctrl_input <= "1000"; input <= input16; load_done <= '1'; send_ctrl_nxt <= "10000";
                        when others => load_done <= '0'; send_ctrl_nxt <= send_ctrl;
                    end case;
                    
                when "10" => 
                    state_nxt <= s_send;
                    case send_ctrl is 
                        when "10000" => ctrl_input <= "0001"; input <= input17; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10001" => ctrl_input <= "0010"; input <= input18; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10010" => ctrl_input <= "0011"; input <= input19; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10011" => ctrl_input <= "0100"; input <= input20; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10100" => ctrl_input <= "0101"; input <= input21; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10101" => ctrl_input <= "0110"; input <= input22; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10110" => ctrl_input <= "0111"; input <= input23; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1;
                        when "10111" => ctrl_input <= "1000"; input <= input24; load_done <= '1'; send_ctrl_nxt <= "11000";
                        when others => load_done <= '0'; send_ctrl_nxt <= send_ctrl;
                    end case;
                    
                    
                when "11" => 
                    case send_ctrl is 
                        when "11000" => ctrl_input <= "0001"; input <= input25; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11001" => ctrl_input <= "0010"; input <= input26; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11010" => ctrl_input <= "0011"; input <= input27; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11011" => ctrl_input <= "0100"; input <= input28; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11100" => ctrl_input <= "0101"; input <= input29; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11101" => ctrl_input <= "0110"; input <= input30; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11110" => ctrl_input <= "0111"; input <= input31; load_done <= '0'; send_ctrl_nxt <= send_ctrl + 1; state_nxt <= s_send;
                        when "11111" => ctrl_input <= "1000"; input <= input32; load_done <= '1'; send_ctrl_nxt <= (others => '0'); state_nxt <= s_initial; --at the end of a matrics and jump to the begining 
                        when others => load_done <= '0'; send_ctrl_nxt <= send_ctrl; state_nxt <= s_send;
                    end case;
                
                when others => 
                    state_nxt <= s_send;
            end case;
        
    end case;


end process;


input01_nxt <= input_in(7 downto 0) when counter = "000001" else input01; 
input02_nxt <= input_in(7 downto 0) when counter = "000010" else input02; 
input03_nxt <= input_in(7 downto 0) when counter = "000011" else input03; 
input04_nxt <= input_in(7 downto 0) when counter = "000100" else input04; 
input05_nxt <= input_in(7 downto 0) when counter = "000101" else input05; 
input06_nxt <= input_in(7 downto 0) when counter = "000110" else input06; 
input07_nxt <= input_in(7 downto 0) when counter = "000111" else input07; 
input08_nxt <= input_in(7 downto 0) when counter = "001000" else input08; 
input09_nxt <= input_in(7 downto 0) when counter = "001001" else input09; 
input10_nxt <= input_in(7 downto 0) when counter = "001010" else input10; 
input11_nxt <= input_in(7 downto 0) when counter = "001011" else input11; 
input12_nxt <= input_in(7 downto 0) when counter = "001100" else input12; 
input13_nxt <= input_in(7 downto 0) when counter = "001101" else input13; 
input14_nxt <= input_in(7 downto 0) when counter = "001110" else input14; 
input15_nxt <= input_in(7 downto 0) when counter = "001111" else input15; 
input16_nxt <= input_in(7 downto 0) when counter = "010000" else input16; 
input17_nxt <= input_in(7 downto 0) when counter = "010001" else input17; 
input18_nxt <= input_in(7 downto 0) when counter = "010010" else input18; 
input19_nxt <= input_in(7 downto 0) when counter = "010011" else input19; 
input20_nxt <= input_in(7 downto 0) when counter = "010100" else input20; 
input21_nxt <= input_in(7 downto 0) when counter = "010101" else input21; 
input22_nxt <= input_in(7 downto 0) when counter = "010110" else input22; 
input23_nxt <= input_in(7 downto 0) when counter = "010111" else input23; 
input24_nxt <= input_in(7 downto 0) when counter = "011000" else input24; 
input25_nxt <= input_in(7 downto 0) when counter = "011001" else input25; 
input26_nxt <= input_in(7 downto 0) when counter = "011010" else input26; 
input27_nxt <= input_in(7 downto 0) when counter = "011011" else input27; 
input28_nxt <= input_in(7 downto 0) when counter = "011100" else input28; 
input29_nxt <= input_in(7 downto 0) when counter = "011101" else input29; 
input30_nxt <= input_in(7 downto 0) when counter = "011110" else input30; 
input31_nxt <= input_in(7 downto 0) when counter = "011111" else input31; 
input32_nxt <= input_in(7 downto 0) when counter = "100000" else input32; 
                
ldinput_done <= '1' when counter = "100000" else '0';

counter_ctrl: FF 
  generic map(N => 6)
  port map(   D     =>counter_nxt,
              Q     =>counter,
            clk     =>clk,
            reset   =>reset
      );

input_01: FF 
  generic map(N => 8)
  port map(   D     =>input01_nxt,
              Q     =>input01,
            clk     =>clk,
            reset   =>reset
      );
input_02: FF 
  generic map(N => 8)
  port map(   D     =>input02_nxt,
              Q     =>input02,
            clk     =>clk,
            reset   =>reset
      );
input_03: FF 
  generic map(N => 8)
  port map(   D     =>input03_nxt,
              Q     =>input03,
            clk     =>clk,
            reset   =>reset
      );
input_04: FF 
  generic map(N => 8)
  port map(   D     =>input04_nxt,
              Q     =>input04,
            clk     =>clk,
            reset   =>reset
      );
input_05: FF 
  generic map(N => 8)
  port map(   D     =>input05_nxt,
              Q     =>input05,
            clk     =>clk,
            reset   =>reset
      );
input_06: FF 
  generic map(N => 8)
  port map(   D     =>input06_nxt,
              Q     =>input06,
            clk     =>clk,
            reset   =>reset
      );
input_07: FF 
  generic map(N => 8)
  port map(   D     =>input07_nxt,
              Q     =>input07,
            clk     =>clk,
            reset   =>reset
      );
input_08: FF 
  generic map(N => 8)
  port map(   D     =>input08_nxt,
              Q     =>input08,
            clk     =>clk,
            reset   =>reset
      );
input_09: FF 
  generic map(N => 8)
  port map(   D     =>input09_nxt,
              Q     =>input09,
            clk     =>clk,
            reset   =>reset
      );
input_10: FF 
  generic map(N => 8)
  port map(   D     =>input10_nxt,
              Q     =>input10,
            clk     =>clk,
            reset   =>reset
      );
input_11: FF 
  generic map(N => 8)
  port map(   D     =>input11_nxt,
              Q     =>input11,
            clk     =>clk,
            reset   =>reset
      );
input_12: FF 
  generic map(N => 8)
  port map(   D     =>input12_nxt,
              Q     =>input12,
            clk     =>clk,
            reset   =>reset
      );
input_13: FF 
  generic map(N => 8)
  port map(   D     =>input13_nxt,
              Q     =>input13,
            clk     =>clk,
            reset   =>reset
      );
input_14: FF 
  generic map(N => 8)
  port map(   D     =>input14_nxt,
              Q     =>input14,
            clk     =>clk,
            reset   =>reset
      );
input_15: FF 
  generic map(N => 8)
  port map(   D     =>input15_nxt,
              Q     =>input15,
            clk     =>clk,
            reset   =>reset
      );
input_16: FF 
  generic map(N => 8)
  port map(   D     =>input16_nxt,
              Q     =>input16,
            clk     =>clk,
            reset   =>reset
      );
input_17: FF 
  generic map(N => 8)
  port map(   D     =>input17_nxt,
              Q     =>input17,
            clk     =>clk,
            reset   =>reset
      );
input_18: FF 
  generic map(N => 8)
  port map(   D     =>input18_nxt,
              Q     =>input18,
            clk     =>clk,
            reset   =>reset
      );
input_19: FF 
  generic map(N => 8)
  port map(   D     =>input19_nxt,
              Q     =>input19,
            clk     =>clk,
            reset   =>reset
      );
input_20: FF 
  generic map(N => 8)
  port map(   D     =>input20_nxt,
              Q     =>input20,
            clk     =>clk,
            reset   =>reset
      );
input_21: FF 
  generic map(N => 8)
  port map(   D     =>input21_nxt,
              Q     =>input21,
            clk     =>clk,
            reset   =>reset
      );
input_22: FF 
  generic map(N => 8)
  port map(   D     =>input22_nxt,
              Q     =>input22,
            clk     =>clk,
            reset   =>reset
      );
input_23: FF 
  generic map(N => 8)
  port map(   D     =>input23_nxt,
              Q     =>input23,
            clk     =>clk,
            reset   =>reset
      );
input_24: FF 
  generic map(N => 8)
  port map(   D     =>input24_nxt,
              Q     =>input24,
            clk     =>clk,
            reset   =>reset
      );
input_25: FF 
  generic map(N => 8)
  port map(   D     =>input25_nxt,
              Q     =>input25,
            clk     =>clk,
            reset   =>reset
      );
input_26: FF 
  generic map(N => 8)
  port map(   D     =>input26_nxt,
              Q     =>input26,
            clk     =>clk,
            reset   =>reset
      );
input_27: FF 
  generic map(N => 8)
  port map(   D     =>input27_nxt,
              Q     =>input27,
            clk     =>clk,
            reset   =>reset
      );
input_28: FF 
  generic map(N => 8)
  port map(   D     =>input28_nxt,
              Q     =>input28,
            clk     =>clk,
            reset   =>reset
      );
input_29: FF 
  generic map(N => 8)
  port map(   D     =>input29_nxt,
              Q     =>input29,
            clk     =>clk,
            reset   =>reset
      );
input_30: FF 
  generic map(N => 8)
  port map(   D     =>input30_nxt,
              Q     =>input30,
            clk     =>clk,
            reset   =>reset
      );
input_31: FF 
  generic map(N => 8)
  port map(   D     =>input31_nxt,
              Q     =>input31,
            clk     =>clk,
            reset   =>reset
      );
input_32: FF 
  generic map(N => 8)
  port map(   D     =>input32_nxt,
              Q     =>input32,
            clk     =>clk,
            reset   =>reset
      );                      



end Behavioral;
