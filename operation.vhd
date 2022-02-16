
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;

entity operation is
  Port (
        clk, reset      : in std_logic;
        
        --begin_coeff2op  : in std_logic;
        flag_data2op    : in std_logic;
        data2op         : in std_logic_vector(6 downto 0);
        
 ---------------------------------------------------------------- 
        data2op_done    : out std_logic; 
        
        op_done         : out std_logic;
        
        out_ready       : out std_logic;
        result          : out std_logic_vector(16 downto 0);
        
        compare_done    : out std_logic;
        compare_out     : out std_logic_vector(16 downto 0)
        
  );
end operation;

architecture Behavioral of operation is
    
    type state_type is (s_store, s_mult1, s_mult2, s_mult3, s_mult4, s_add, s_send_data, s_send_compare);
    signal state_reg, state_nxt : state_type;
    
    signal start_store  : std_logic;
    signal column       : std_logic_vector(1 downto 0);
    signal column_nxt   : std_logic_vector(1 downto 0);
    
    signal coeff01      : std_logic_vector(6 downto 0);
    signal coeff02      : std_logic_vector(6 downto 0);
    signal coeff03      : std_logic_vector(6 downto 0);
    signal coeff04      : std_logic_vector(6 downto 0);
    signal coeff05      : std_logic_vector(6 downto 0);
    signal coeff06      : std_logic_vector(6 downto 0);
    signal coeff07      : std_logic_vector(6 downto 0);
    signal coeff08      : std_logic_vector(6 downto 0);
    signal coeff09      : std_logic_vector(6 downto 0);
    signal coeff10      : std_logic_vector(6 downto 0);
    signal coeff11      : std_logic_vector(6 downto 0);
    signal coeff12      : std_logic_vector(6 downto 0);
    signal coeff13      : std_logic_vector(6 downto 0);
    signal coeff14      : std_logic_vector(6 downto 0);
    signal coeff15      : std_logic_vector(6 downto 0);
    signal coeff16      : std_logic_vector(6 downto 0);
    signal coeff17      : std_logic_vector(6 downto 0);
    signal coeff18      : std_logic_vector(6 downto 0);
    signal coeff19      : std_logic_vector(6 downto 0);
    signal coeff20      : std_logic_vector(6 downto 0);
    signal coeff21      : std_logic_vector(6 downto 0);
    signal coeff22      : std_logic_vector(6 downto 0);
    signal coeff23      : std_logic_vector(6 downto 0);
    signal coeff24      : std_logic_vector(6 downto 0);
    signal coeff25      : std_logic_vector(6 downto 0);
    signal coeff26      : std_logic_vector(6 downto 0);
    signal coeff27      : std_logic_vector(6 downto 0);
    signal coeff28      : std_logic_vector(6 downto 0);
    signal coeff29      : std_logic_vector(6 downto 0);
    signal coeff30      : std_logic_vector(6 downto 0);
    signal coeff31      : std_logic_vector(6 downto 0);
    signal coeff32      : std_logic_vector(6 downto 0);

    signal input01      : std_logic_vector(7 downto 0);
    signal input02      : std_logic_vector(7 downto 0);
    signal input03      : std_logic_vector(7 downto 0);
    signal input04      : std_logic_vector(7 downto 0);
    signal input05      : std_logic_vector(7 downto 0);
    signal input06      : std_logic_vector(7 downto 0);
    signal input07      : std_logic_vector(7 downto 0);
    signal input08      : std_logic_vector(7 downto 0);
    
    signal output_reg1  : std_logic_vector(15 downto 0);
    signal output_reg2  : std_logic_vector(15 downto 0);
    signal output_reg3  : std_logic_vector(15 downto 0);
    signal output_reg4  : std_logic_vector(15 downto 0);
    signal output_reg5  : std_logic_vector(15 downto 0);
    signal output_reg6  : std_logic_vector(15 downto 0);
    signal output_reg7  : std_logic_vector(15 downto 0);
    signal output_reg8  : std_logic_vector(15 downto 0);
    
    signal output1      : std_logic_vector(16 downto 0);
    signal output2      : std_logic_vector(16 downto 0);
    signal output3      : std_logic_vector(16 downto 0);
    signal output4      : std_logic_vector(16 downto 0);
    
    signal compare      : std_logic_vector(16 downto 0) := (others => '0');
    signal compare_nxt  : std_logic_vector(16 downto 0) := (others => '0');

begin

--state ctrl-----------------------------------
process (clk, reset, column_nxt)
begin
    if reset = '1' then 
        state_reg <= s_store; 
        column <= "00";
        compare <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        column <= column_nxt;
        compare <= compare_nxt;
    end if;         
end process;

-----------------------------------------
process (state_reg, s_store, s_mult1, s_mult2, s_mult3, s_mult4, s_add, s_send_data, s_send_compare, column)
begin 
    case state_reg is 
        when s_store => 
            column_nxt <= "00";
            out_ready <= '0';
            op_done <= '0';
            compare_done <= '0';
            if flag_data2op = '1' then 
                state_nxt <= s_mult1; 
                start_store <= '0';
            else 
                state_nxt <= s_store;
                start_store <= '1';
            end if;
        
        when s_mult1 => 
            state_nxt <= s_mult2;
            out_ready <= '0';
            case column is
                when "00" => output_reg1 <= input01 * coeff01; output_reg2 <= input02 * coeff05;
                when "01" => output_reg1 <= input01 * coeff02; output_reg2 <= input02 * coeff06;
                when "10" => output_reg1 <= input01 * coeff03; output_reg2 <= input02 * coeff07;
                when "11" => output_reg1 <= input01 * coeff04; output_reg2 <= input02 * coeff08;
            end case;
            
        when s_mult2 => 
            state_nxt <= s_mult3;
            case column is
                when "00" => output_reg3 <= input03 * coeff09; output_reg4 <= input04 * coeff13;
                when "01" => output_reg3 <= input03 * coeff10; output_reg4 <= input04 * coeff14;
                when "10" => output_reg3 <= input03 * coeff11; output_reg4 <= input04 * coeff15;
                when "11" => output_reg3 <= input03 * coeff12; output_reg4 <= input04 * coeff16;
            end case;
        
        when s_mult3 => 
            state_nxt <= s_mult4;
            case column is 
                when "00" => output_reg5 <= input05 * coeff17; output_reg6 <= input06 * coeff21; 
                when "01" => output_reg5 <= input05 * coeff18; output_reg6 <= input06 * coeff22; 
                when "10" => output_reg5 <= input05 * coeff19; output_reg6 <= input06 * coeff23; 
                when "11" => output_reg5 <= input05 * coeff20; output_reg6 <= input06 * coeff24; 
            end case;
            
        when s_mult4 => 
            state_nxt <= s_add;
            case column is 
                when "00" => output_reg7 <= input07 * coeff25; output_reg8 <= input08 * coeff29; 
                when "01" => output_reg7 <= input07 * coeff26; output_reg8 <= input08 * coeff30; 
                when "10" => output_reg7 <= input07 * coeff27; output_reg8 <= input08 * coeff31; 
                when "11" => output_reg7 <= input07 * coeff28; output_reg8 <= input08 * coeff32; 
             end case;  

        when s_add => 
            case column is 
                when "00" => 
                    output1 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8; 
                when "01" => 
                    output2 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8;                  
                when "10" => 
                    output3 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8;
                when "11" => 
                    output4 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8;
            end case; 
       
        when s_send_data => 
            case column is 
                when "00" => 
                    state_nxt <= s_mult1;
                    out_ready <= '1';
                    column_nxt <= "01";
                    result <= output1; 
                    if compare < output1 then 
                        compare_nxt <= output1; 
                    else
                        compare_nxt <= compare;
                    end if;
                    
                when "01" => 
                    state_nxt <= s_mult1;
                    out_ready <= '1'; 
                    column_nxt <= "10";  
                    result <= output2;
                    if compare < output2 then 
                        compare_nxt <= output2;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "10" => 
                    state_nxt <= s_mult1;
                    out_ready <= '1'; 
                    column_nxt <= "11"; 
                    result <= output3;
                    if compare < output3 then 
                        compare_nxt <= output3;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "11" => 
                    state_nxt <= s_send_compare;                    
                    out_ready <= '1';
                    column_nxt <= "00"; 
                    result <= output4;  
                    if compare < output4 then 
                        compare_nxt <= output4;
                    else 
                        compare_nxt <= compare;
                    end if;      
            end case;
        
        when s_send_compare => 
            op_done <= '1';
            compare_done <= '1'; 
            compare_out <= compare;
            state_nxt <= s_store; 
    end case;


end process;





store_data : process(start_store, data2op)
begin 
    

end process; 






end Behavioral;
