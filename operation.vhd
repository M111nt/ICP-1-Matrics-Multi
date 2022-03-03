
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity operation is
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
        --compare_done    : out std_logic;
        compare_out     : out std_logic_vector(18 downto 0)
        
  );
end operation;

architecture Behavioral of operation is
    
    type state_type is (s_initial, s_store, s_mult1, s_mult2, s_mult3, s_mult4, s_add, s_send_data, s_send_compare);
    signal state_reg, state_nxt : state_type;
    
    signal output_test  : std_logic_vector(16 downto 0);
    
    signal start_store  : std_logic;
    signal column       : std_logic_vector(1 downto 0);
    signal column_nxt   : std_logic_vector(1 downto 0);
    signal data2op_done : std_logic; 
    
    signal input_test   : std_logic_vector(7 downto 0);
    signal coeff01      : std_logic_vector(7 downto 0);
    signal coeff02      : std_logic_vector(7 downto 0);
    signal coeff03      : std_logic_vector(7 downto 0);
    signal coeff04      : std_logic_vector(7 downto 0);
    signal coeff05      : std_logic_vector(7 downto 0);
    signal coeff06      : std_logic_vector(7 downto 0);
    signal coeff07      : std_logic_vector(7 downto 0);
    signal coeff08      : std_logic_vector(7 downto 0);
    signal coeff09      : std_logic_vector(7 downto 0);
    signal coeff10      : std_logic_vector(7 downto 0);
    signal coeff11      : std_logic_vector(7 downto 0);
    signal coeff12      : std_logic_vector(7 downto 0);
    signal coeff13      : std_logic_vector(7 downto 0);
    signal coeff14      : std_logic_vector(7 downto 0);
    signal coeff15      : std_logic_vector(7 downto 0);
    signal coeff16      : std_logic_vector(7 downto 0);
    signal coeff17      : std_logic_vector(7 downto 0);
    signal coeff18      : std_logic_vector(7 downto 0);
    signal coeff19      : std_logic_vector(7 downto 0);
    signal coeff20      : std_logic_vector(7 downto 0);
    signal coeff21      : std_logic_vector(7 downto 0);
    signal coeff22      : std_logic_vector(7 downto 0);
    signal coeff23      : std_logic_vector(7 downto 0);
    signal coeff24      : std_logic_vector(7 downto 0);
    signal coeff25      : std_logic_vector(7 downto 0);
    signal coeff26      : std_logic_vector(7 downto 0);
    signal coeff27      : std_logic_vector(7 downto 0);
    signal coeff28      : std_logic_vector(7 downto 0);
    signal coeff29      : std_logic_vector(7 downto 0);
    signal coeff30      : std_logic_vector(7 downto 0);
    signal coeff31      : std_logic_vector(7 downto 0);
    signal coeff32      : std_logic_vector(7 downto 0);

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
    
--    signal output_tran1 : std_logic_vector(18 downto 0);
--    signal output_tran2 : std_logic_vector(18 downto 0);
--    signal output_tran3 : std_logic_vector(18 downto 0);
--    signal output_tran4 : std_logic_vector(18 downto 0);
--    signal output_tran5 : std_logic_vector(18 downto 0);
--    signal output_tran6 : std_logic_vector(18 downto 0);
--    signal output_tran7 : std_logic_vector(18 downto 0);
--    signal output_tran8 : std_logic_vector(18 downto 0);
    
    signal output1      : std_logic_vector(18 downto 0);
    signal output2      : std_logic_vector(18 downto 0);
    signal output3      : std_logic_vector(18 downto 0);
    signal output4      : std_logic_vector(18 downto 0);
    
    signal compare      : std_logic_vector(18 downto 0) := (others => '0');
    signal compare_nxt  : std_logic_vector(18 downto 0) := (others => '0');

begin

--state ctrl-----------------------------------
process (clk, reset, column_nxt, compare_nxt)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        column <= "00";
        compare <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        column <= column_nxt;
        compare <= compare_nxt;
    end if;         
end process;

-----------------------------------------
process (state_reg, column, data2op_done,--flag_data2op, -- 
--        input01, input02, input03, input04, input05, input06, input07, input08,
--        coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09, coeff10, 
--        coeff11, coeff12, coeff13, coeff14, coeff15, coeff16, coeff17, coeff18, coeff19, coeff20, 
--        coeff21, coeff22, coeff23, coeff24, coeff25, coeff26, coeff27, coeff28, coeff29, coeff30, 
--        coeff31, coeff32, 
        output_reg1, output_reg2, output_reg3, output_reg4, output_reg5, output_reg6, output_reg7, output_reg8,
        output1, output2, output3, output4, 
        compare
        )

begin 
    case state_reg is 
        
        when s_initial => 
            column_nxt <= "00";
            out_ready <= '0';
            op_done <= '0';
            --compare_done <= '0';
            compare_out <= (others => '0');
            if op_en = '1' then 
                state_nxt <= s_store;
            else
                state_nxt<= s_initial;
            end if;
        
        when s_store => 
            --column_nxt <= "00";
            --out_ready <= '0';
            --op_done <= '0';
            --compare_done <= '0';
            --if flag_data2op = '1' then 
            if data2op_done = '1' then            
                state_nxt <= s_mult1; 
                --start_store <= '0';
            else 
                state_nxt <= s_store;
                --start_store <= '1';
            end if;
        
        when s_mult1 => 
            state_nxt <= s_mult2;
            out_ready <= '0';
            case column is
                when "00" => output_reg1 <= input01 * coeff01; output_reg2 <= input02 * coeff05;
                when "01" => output_reg1 <= input01 * coeff02; output_reg2 <= input02 * coeff06;
                when "10" => output_reg1 <= input01 * coeff03; output_reg2 <= input02 * coeff07;
                when "11" => output_reg1 <= input01 * coeff04; output_reg2 <= input02 * coeff08;
                when others => output_reg1 <= input01 * coeff01; output_reg2 <= input02 * coeff05;
            end case;
            
        when s_mult2 => 
            state_nxt <= s_mult3;
            case column is
                when "00" => output_reg3 <= input03 * coeff09; output_reg4 <= input04 * coeff13;
                when "01" => output_reg3 <= input03 * coeff10; output_reg4 <= input04 * coeff14;
                when "10" => output_reg3 <= input03 * coeff11; output_reg4 <= input04 * coeff15;
                when "11" => output_reg3 <= input03 * coeff12; output_reg4 <= input04 * coeff16;
                when others => output_reg3 <= input03 * coeff09; output_reg4 <= input04 * coeff13;
            end case;
        
        when s_mult3 => 
            state_nxt <= s_mult4;
            case column is 
                when "00" => output_reg5 <= input05 * coeff17; output_reg6 <= input06 * coeff21; 
                when "01" => output_reg5 <= input05 * coeff18; output_reg6 <= input06 * coeff22; 
                when "10" => output_reg5 <= input05 * coeff19; output_reg6 <= input06 * coeff23; 
                when "11" => output_reg5 <= input05 * coeff20; output_reg6 <= input06 * coeff24; 
                when others => output_reg5 <= input05 * coeff17; output_reg6 <= input06 * coeff21;
            end case;
            
        when s_mult4 => 
            state_nxt <= s_add;
            case column is 
                when "00" => output_reg7 <= input07 * coeff25; output_reg8 <= input08 * coeff29; 
                when "01" => output_reg7 <= input07 * coeff26; output_reg8 <= input08 * coeff30; 
                when "10" => output_reg7 <= input07 * coeff27; output_reg8 <= input08 * coeff31; 
                when "11" => output_reg7 <= input07 * coeff28; output_reg8 <= input08 * coeff32; 
                when others => output_reg7 <= input07 * coeff25; output_reg8 <= input08 * coeff29;
             end case;  

--        when s_trans => 
--            output_tran1 <= "000" & output_reg1;
--            output_tran2 <= "000" & output_reg2;
--            output_tran3 <= "000" & output_reg3;
--            output_tran4 <= "000" & output_reg4;
--            output_tran5 <= "000" & output_reg5;
--            output_tran6 <= "000" & output_reg6;
--            output_tran7 <= "000" & output_reg7;
--            output_tran8 <= "000" & output_reg8;
--            state_nxt <= s_add;

        when s_add => 
            case column is 
                when "00" => 
                    --output1 <= output_tran1 + output_tran2 + output_tran3 + output_tran4 + output_tran5 + output_tran6 + output_tran7 + output_tran8; 
                    output1 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "01" => 
                    --output2 <= output_tran1 + output_tran2 + output_tran3 + output_tran4 + output_tran5 + output_tran6 + output_tran7 + output_tran8;                 
                    output2 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "10" => 
                    --output3 <= output_tran1 + output_tran2 + output_tran3 + output_tran4 + output_tran5 + output_tran6 + output_tran7 + output_tran8;
                    output3 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "11" => 
                    --output4 <= output_tran1 + output_tran2 + output_tran3 + output_tran4 + output_tran5 + output_tran6 + output_tran7 + output_tran8;
                    output4 <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when others => 
                    --output1 <= output_tran1 + output_tran2 + output_tran3 + output_tran4 + output_tran5 + output_tran6 + output_tran7 + output_tran8;                   
                    state_nxt <= s_add;
            end case; 
       
        when s_send_data => 
            case column is 
                when "00" => 
                    state_nxt <= s_mult1;
                    out_ready <= '0';
                    column_nxt <= "01";
                    result1 <= output1; 
                    if compare < output1 then 
                        compare_nxt <= output1; 
                    else
                        compare_nxt <= compare;
                    end if;
                    
                when "01" => 
                    state_nxt <= s_mult1;
                    out_ready <= '0'; 
                    column_nxt <= "10";  
                    result2 <= output2;
                    if compare < output2 then 
                        compare_nxt <= output2;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "10" => 
                    state_nxt <= s_mult1;
                    out_ready <= '0'; 
                    column_nxt <= "11"; 
                    result3 <= output3;
                    if compare < output3 then 
                        compare_nxt <= output3;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "11" => 
                    state_nxt <= s_send_compare;                    
                    out_ready <= '1';
                    column_nxt <= "00"; 
                    result4 <= output4;  
                    if compare < output4 then 
                        compare_nxt <= output4;
                    else 
                        compare_nxt <= compare;
                    end if;  
                    
                when others => 
                    state_nxt <= s_mult1;  
            end case;
        
        when s_send_compare => 
            out_ready <= '0';
            op_done <= '1';
            --compare_done <= '1'; 
            compare_out <= compare;
            state_nxt <= s_initial; 
    end case;


end process;

----------------------------------------------------------------------------------------

store_data : process( address2op)--start_store,
begin 
--    if start_store = '1' then
        case address2op is 
            when "000001" =>  coeff01 <= data2op; data2op_done <= '0';
            when "000010" =>  coeff02 <= data2op; data2op_done <= '0';
            when "000011" =>  coeff03 <= data2op; data2op_done <= '0';
            when "000100" =>  coeff04 <= data2op; data2op_done <= '0';
            when "000101" =>  coeff05 <= data2op; data2op_done <= '0';
            when "000110" =>  coeff06 <= data2op; data2op_done <= '0';
            when "000111" =>  coeff07 <= data2op; data2op_done <= '0';
            when "001000" =>  coeff08 <= data2op; data2op_done <= '0';
            when "001001" =>  coeff09 <= data2op; data2op_done <= '0';
            when "001010" =>  coeff10 <= data2op; data2op_done <= '0';
            when "001011" =>  coeff11 <= data2op; data2op_done <= '0';
            when "001100" =>  coeff12 <= data2op; data2op_done <= '0';
            when "001101" =>  coeff13 <= data2op; data2op_done <= '0';
            when "001110" =>  coeff14 <= data2op; data2op_done <= '0';
            when "001111" =>  coeff15 <= data2op; data2op_done <= '0';
            when "010000" =>  coeff16 <= data2op; data2op_done <= '0';
            when "010001" =>  coeff17 <= data2op; data2op_done <= '0';
            when "010010" =>  coeff18 <= data2op; data2op_done <= '0';
            when "010011" =>  coeff19 <= data2op; data2op_done <= '0';
            when "010100" =>  coeff20 <= data2op; data2op_done <= '0';
            when "010101" =>  coeff21 <= data2op; data2op_done <= '0';
            when "010110" =>  coeff22 <= data2op; data2op_done <= '0';
            when "010111" =>  coeff23 <= data2op; data2op_done <= '0';
            when "011000" =>  coeff24 <= data2op; data2op_done <= '0';
            when "011001" =>  coeff25 <= data2op; data2op_done <= '0';
            when "011010" =>  coeff26 <= data2op; data2op_done <= '0';
            when "011011" =>  coeff27 <= data2op; data2op_done <= '0';
            when "011100" =>  coeff28 <= data2op; data2op_done <= '0';
            when "011101" =>  coeff29 <= data2op; data2op_done <= '0';
            when "011110" =>  coeff30 <= data2op; data2op_done <= '0';
            when "011111" =>  coeff31 <= data2op; data2op_done <= '0';
            when "100000" =>  coeff32 <= data2op; data2op_done <= '0';
                                      
            when "100001" =>  input01 <= data2op; data2op_done <= '0';
            when "100010" =>  input02 <= data2op; data2op_done <= '0';
            when "100011" =>  input03 <= data2op; data2op_done <= '0';
            when "100100" =>  input04 <= data2op; data2op_done <= '0';
            when "100101" =>  input05 <= data2op; data2op_done <= '0';
            when "100110" =>  input06 <= data2op; data2op_done <= '0';
            when "100111" =>  input07 <= data2op; data2op_done <= '0';
            when "101000" =>  input08 <= data2op; data2op_done <= '1'; 
            when others => input_test <= (others => '0'); data2op_done <= '1';
        end case;
--    else 
--        input_test <= (others => '0');
--        data2op_done <= '0';
--    end if;

end process; 



end Behavioral;
