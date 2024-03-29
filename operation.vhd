
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity operation is
  Port (
        clk, reset      : in std_logic;
        
        op_en           : in std_logic;
        data2op         : in std_logic_vector(7 downto 0);
        address2op      : in std_logic_vector(5 downto 0);
 ---------------------------------------------------------------- 
        -- to the controller--------------------------------------
        
        op_done         : out std_logic;
        
        result1_out     : out std_logic_vector(18 downto 0);
        result2_out     : out std_logic_vector(18 downto 0);
        result3_out     : out std_logic_vector(18 downto 0);
        result4_out     : out std_logic_vector(18 downto 0);

        --to the compare---------------------------------------------
        compare_out     : out std_logic_vector(18 downto 0)
        
  );
end operation;

architecture Behavioral of operation is
    
    type state_type is (s_initial, s_store, s_mult1, s_keep1, s_mult2, s_keep2, s_mult3, s_keep3, s_mult4, s_keep4, s_add, s_send_data, s_send_compare);
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
    
    signal coeff01_nxt      : std_logic_vector(7 downto 0);
    signal coeff02_nxt      : std_logic_vector(7 downto 0);
    signal coeff03_nxt      : std_logic_vector(7 downto 0);
    signal coeff04_nxt      : std_logic_vector(7 downto 0);
    signal coeff05_nxt      : std_logic_vector(7 downto 0);
    signal coeff06_nxt      : std_logic_vector(7 downto 0);
    signal coeff07_nxt      : std_logic_vector(7 downto 0);
    signal coeff08_nxt      : std_logic_vector(7 downto 0);
    signal coeff09_nxt      : std_logic_vector(7 downto 0);
    signal coeff10_nxt      : std_logic_vector(7 downto 0);
    signal coeff11_nxt      : std_logic_vector(7 downto 0);
    signal coeff12_nxt      : std_logic_vector(7 downto 0);
    signal coeff13_nxt      : std_logic_vector(7 downto 0);
    signal coeff14_nxt      : std_logic_vector(7 downto 0);
    signal coeff15_nxt      : std_logic_vector(7 downto 0);
    signal coeff16_nxt      : std_logic_vector(7 downto 0);
    signal coeff17_nxt      : std_logic_vector(7 downto 0);
    signal coeff18_nxt      : std_logic_vector(7 downto 0);
    signal coeff19_nxt      : std_logic_vector(7 downto 0);
    signal coeff20_nxt      : std_logic_vector(7 downto 0);
    signal coeff21_nxt      : std_logic_vector(7 downto 0);
    signal coeff22_nxt      : std_logic_vector(7 downto 0);
    signal coeff23_nxt      : std_logic_vector(7 downto 0);
    signal coeff24_nxt      : std_logic_vector(7 downto 0);
    signal coeff25_nxt      : std_logic_vector(7 downto 0);
    signal coeff26_nxt      : std_logic_vector(7 downto 0);
    signal coeff27_nxt      : std_logic_vector(7 downto 0);
    signal coeff28_nxt      : std_logic_vector(7 downto 0);
    signal coeff29_nxt      : std_logic_vector(7 downto 0);
    signal coeff30_nxt      : std_logic_vector(7 downto 0);
    signal coeff31_nxt      : std_logic_vector(7 downto 0);
    signal coeff32_nxt      : std_logic_vector(7 downto 0);

    signal input01_nxt      : std_logic_vector(7 downto 0);
    signal input02_nxt      : std_logic_vector(7 downto 0);
    signal input03_nxt      : std_logic_vector(7 downto 0);
    signal input04_nxt      : std_logic_vector(7 downto 0);
    signal input05_nxt      : std_logic_vector(7 downto 0);
    signal input06_nxt      : std_logic_vector(7 downto 0);
    signal input07_nxt      : std_logic_vector(7 downto 0);
    signal input08_nxt      : std_logic_vector(7 downto 0);
    
    signal output_reg1  : std_logic_vector(15 downto 0);
    signal output_reg2  : std_logic_vector(15 downto 0);
    signal output_reg3  : std_logic_vector(15 downto 0);
    signal output_reg4  : std_logic_vector(15 downto 0);
    signal output_reg5  : std_logic_vector(15 downto 0);
    signal output_reg6  : std_logic_vector(15 downto 0);
    signal output_reg7  : std_logic_vector(15 downto 0);
    signal output_reg8  : std_logic_vector(15 downto 0);
    
    signal output_reg1_nxt  : std_logic_vector(15 downto 0);
    signal output_reg2_nxt  : std_logic_vector(15 downto 0);
    signal output_reg3_nxt  : std_logic_vector(15 downto 0);
    signal output_reg4_nxt  : std_logic_vector(15 downto 0);
    signal output_reg5_nxt  : std_logic_vector(15 downto 0);
    signal output_reg6_nxt  : std_logic_vector(15 downto 0);
    signal output_reg7_nxt  : std_logic_vector(15 downto 0);
    signal output_reg8_nxt  : std_logic_vector(15 downto 0);
    
    signal output1      : std_logic_vector(18 downto 0);
    signal output2      : std_logic_vector(18 downto 0);
    signal output3      : std_logic_vector(18 downto 0);
    signal output4      : std_logic_vector(18 downto 0);
    
    signal output1_nxt  : std_logic_vector(18 downto 0);
    signal output2_nxt  : std_logic_vector(18 downto 0);
    signal output3_nxt  : std_logic_vector(18 downto 0);
    signal output4_nxt  : std_logic_vector(18 downto 0);
    
    signal result1      : std_logic_vector(18 downto 0);
    signal result2      : std_logic_vector(18 downto 0);
    signal result3      : std_logic_vector(18 downto 0);
    signal result4      : std_logic_vector(18 downto 0);
    signal result1_nxt  : std_logic_vector(18 downto 0);
    signal result2_nxt  : std_logic_vector(18 downto 0);
    signal result3_nxt  : std_logic_vector(18 downto 0);
    signal result4_nxt  : std_logic_vector(18 downto 0);
    
    signal compare      : std_logic_vector(18 downto 0) := (others => '0');
    signal compare_nxt  : std_logic_vector(18 downto 0) := (others => '0');

    signal mult1, mult2, mult3, mult4 : std_logic_vector(7 downto 0);
    signal mult1_nxt, mult2_nxt, mult3_nxt, mult4_nxt : std_logic_vector(7 downto 0);
    signal result_1, result_2         : std_logic_vector(15 downto 0);

begin

--state ctrl-----------------------------------
process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
    end if;         
end process;

result_1 <= mult1 * mult2; 
result_2 <= mult3 * mult4;

result1_out <= result1;
result2_out <= result2;
result3_out <= result3;
result4_out <= result4;

compare_out <= compare;
------------------------------------------------------------------------------
process (clk, reset)
begin
    if reset = '1' then 
        column <= "00";
        compare <= (others => '0');
        output_reg1 <= (others => '0');
        output_reg2 <= (others => '0');
        output_reg3 <= (others => '0');
        output_reg4 <= (others => '0');
        output_reg5 <= (others => '0');
        output_reg6 <= (others => '0');
        output_reg7 <= (others => '0');
        output_reg8 <= (others => '0');
        output1 <= (others => '0');
        output2 <= (others => '0');
        output3 <= (others => '0');
        output4 <= (others => '0');
        mult1 <= (others => '0');
        mult2 <= (others => '0');
        mult3 <= (others => '0');
        mult4 <= (others => '0');

    elsif (clk'event and clk = '1') then 
        column <= column_nxt;
        compare <= compare_nxt;
        output_reg1 <= output_reg1_nxt;
        output_reg2 <= output_reg2_nxt;
        output_reg3 <= output_reg3_nxt;
        output_reg4 <= output_reg4_nxt;
        output_reg5 <= output_reg5_nxt;
        output_reg6 <= output_reg6_nxt;
        output_reg7 <= output_reg7_nxt;
        output_reg8 <= output_reg8_nxt;
        output1 <= output1_nxt;
        output2 <= output2_nxt;
        output3 <= output3_nxt;
        output4 <= output4_nxt;
        mult1 <= mult1_nxt;
        mult2 <= mult2_nxt;
        mult3 <= mult3_nxt;
        mult4 <= mult4_nxt;

    end if;         
end process;

-----------------------------------------
process (state_reg, data2op_done,
        output_reg1, output_reg2, output_reg3, output_reg4, output_reg5, output_reg6, output_reg7, output_reg8,
        output1, output2, output3, output4, 
        compare, result_1,result_2
        )

begin 
    
    op_done <= '0';
    result1_nxt <= result1;
    result2_nxt <= result2;
    result3_nxt <= result3;
    result4_nxt <= result4;
    
    column_nxt <= column;
    
    
    output_reg1_nxt <= output_reg1;
    output_reg2_nxt <= output_reg2;
    output_reg3_nxt <= output_reg3;
    output_reg4_nxt <= output_reg4;
    output_reg5_nxt <= output_reg5;
    output_reg6_nxt <= output_reg6;
    output_reg7_nxt <= output_reg7;
    output_reg8_nxt <= output_reg8;
    
    output1_nxt <= output1;
    output2_nxt <= output2;
    output3_nxt <= output3;
    output4_nxt <= output4;
    mult1_nxt <= mult1;
    mult2_nxt <= mult2;
    mult3_nxt <= mult3;
    mult4_nxt <= mult4;
    
    compare_nxt <= compare;

    case state_reg is 
        
        when s_initial => 
            column_nxt <= "00";
            op_done <= '0';
            --compare_out <= (others => '0');
            if op_en = '1' then 
                state_nxt <= s_store;
            else
                state_nxt<= s_initial;
            end if;
        
        when s_store => 
            if data2op_done = '1' then            
                state_nxt <= s_mult1; 
            else 
                state_nxt <= s_store;
            end if;
        
        when s_mult1 => 
            state_nxt <= s_keep1;
            case column is
                when "00" => mult1_nxt <= input01; mult2_nxt <= coeff01; mult3_nxt <= input02; mult4_nxt <= coeff05;
                when "01" => mult1_nxt <= input01; mult2_nxt <= coeff02; mult3_nxt <= input02; mult4_nxt <= coeff06;
                when "10" => mult1_nxt <= input01; mult2_nxt <= coeff03; mult3_nxt <= input02; mult4_nxt <= coeff07;
                when "11" => mult1_nxt <= input01; mult2_nxt <= coeff04; mult3_nxt <= input02; mult4_nxt <= coeff08;
                when others => mult1_nxt <= input01; mult2_nxt <= coeff01; mult3_nxt <= input02; mult4_nxt <= coeff05;
            end case;
            
        when s_keep1 => 
            state_nxt <= s_mult2;
            output_reg1_nxt <= result_1; output_reg2_nxt <= result_2;
            
        when s_mult2 => 
            state_nxt <= s_keep2;
            case column is
                when "00" => mult1_nxt <= input03; mult2_nxt <= coeff09; mult3_nxt <= input04; mult4_nxt <= coeff13;
                when "01" => mult1_nxt <= input03; mult2_nxt <= coeff10; mult3_nxt <= input04; mult4_nxt <= coeff14;
                when "10" => mult1_nxt <= input03; mult2_nxt <= coeff11; mult3_nxt <= input04; mult4_nxt <= coeff15;
                when "11" => mult1_nxt <= input03; mult2_nxt <= coeff12; mult3_nxt <= input04; mult4_nxt <= coeff16;
                when others => mult1_nxt <= input03; mult2_nxt <= coeff09; mult3_nxt <= input04; mult4_nxt <= coeff13;
            end case;
        
        when s_keep2 => 
            state_nxt <= s_mult3;
            output_reg3_nxt <= result_1; output_reg4_nxt <= result_2;
        
        when s_mult3 => 
            state_nxt <= s_keep3;
            case column is 
                when "00" => mult1_nxt <= input05; mult2_nxt <= coeff17; mult3_nxt <= input06; mult4_nxt <= coeff21; 
                when "01" => mult1_nxt <= input05; mult2_nxt <= coeff18; mult3_nxt <= input06; mult4_nxt <= coeff22; 
                when "10" => mult1_nxt <= input05; mult2_nxt <= coeff19; mult3_nxt <= input06; mult4_nxt <= coeff23; 
                when "11" => mult1_nxt <= input05; mult2_nxt <= coeff20; mult3_nxt <= input06; mult4_nxt <= coeff24; 
                when others => mult1_nxt <= input05; mult2_nxt <= coeff17; mult3_nxt <= input06; mult4_nxt <= coeff21;
            end case;
        
        when s_keep3 => 
            state_nxt <= s_mult4;
            output_reg5_nxt <= result_1; output_reg6_nxt <= result_2;
            
        when s_mult4 => 
            state_nxt <= s_keep4;
            case column is 
                when "00" => mult1_nxt <= input07; mult2_nxt <= coeff25; mult3_nxt <= input08; mult4_nxt <= coeff29; 
                when "01" => mult1_nxt <= input07; mult2_nxt <= coeff26; mult3_nxt <= input08; mult4_nxt <= coeff30; 
                when "10" => mult1_nxt <= input07; mult2_nxt <= coeff27; mult3_nxt <= input08; mult4_nxt <= coeff31; 
                when "11" => mult1_nxt <= input07; mult2_nxt <= coeff28; mult3_nxt <= input08; mult4_nxt <= coeff32; 
                when others => mult1_nxt <= input07; mult2_nxt <= coeff25; mult3_nxt <= input08; mult4_nxt <= coeff29; 
             end case;  

        when s_keep4 => 
            state_nxt <= s_add;
            output_reg7_nxt <= result_1; output_reg8_nxt <= result_2;

        when s_add => 
            case column is 
                when "00" => 
                    output1_nxt <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "01" => 
                    output2_nxt <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "10" => 
                    output3_nxt <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when "11" => 
                    output4_nxt <= output_reg1 + output_reg2 + output_reg3 + output_reg4 + output_reg5 + output_reg6 + output_reg7 + output_reg8 + "0000000000000000000";
                    state_nxt <= s_send_data;
                when others => 
                    state_nxt <= s_add;
            end case; 
       
        when s_send_data => 
            case column is 
                when "00" => 
                    state_nxt <= s_mult1;
                    column_nxt <= column + 1;
                    result1_nxt <= output1; 
                    if compare < output1 then 
                        compare_nxt <= output1; 
                    else
                        compare_nxt <= compare;
                    end if;
                    
                when "01" => 
                    state_nxt <= s_mult1;
                    column_nxt <= column + 1;  
                    result2_nxt <= output2;
                    if compare < output2 then 
                        compare_nxt <= output2;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "10" => 
                    state_nxt <= s_mult1;
                    column_nxt <= column + 1; 
                    result3_nxt <= output3;
                    if compare < output3 then 
                        compare_nxt <= output3;
                    else 
                        compare_nxt <= compare;
                    end if; 
                    
                when "11" => 
                    state_nxt <= s_send_compare;                    
                    column_nxt <= "00"; 
                    result4_nxt <= output4;  
                    if compare < output4 then 
                        compare_nxt <= output4;
                    else 
                        compare_nxt <= compare;
                    end if;  
                    
                when others => 
                    state_nxt <= s_mult1;  
            end case;
        
        when s_send_compare => 
            op_done <= '1';
            state_nxt <= s_initial; 
    end case;


end process;

----------------------------------------------------------------------------------------

process(clk, reset)
begin
    if reset = '1' then 
        coeff01 <= (others => '0');
        coeff02 <= (others => '0');
        coeff03 <= (others => '0');
        coeff04 <= (others => '0');
        coeff05 <= (others => '0');
        coeff06 <= (others => '0');
        coeff07 <= (others => '0');
        coeff08 <= (others => '0');
        coeff09 <= (others => '0');
        coeff10 <= (others => '0');
        coeff11 <= (others => '0');
        coeff12 <= (others => '0');
        coeff13 <= (others => '0');
        coeff14 <= (others => '0');
        coeff15 <= (others => '0');
        coeff16 <= (others => '0');
        coeff17 <= (others => '0');
        coeff18 <= (others => '0');
        coeff19 <= (others => '0');
        coeff20 <= (others => '0');
        coeff21 <= (others => '0');
        coeff22 <= (others => '0');
        coeff23 <= (others => '0');
        coeff24 <= (others => '0');
        coeff25 <= (others => '0');
        coeff26 <= (others => '0');
        coeff27 <= (others => '0');
        coeff28 <= (others => '0');
        coeff29 <= (others => '0');
        coeff30 <= (others => '0');
        coeff31 <= (others => '0');
        coeff32 <= (others => '0');
        input01 <= (others => '0');
        input02 <= (others => '0');
        input03 <= (others => '0');
        input04 <= (others => '0');
        input05 <= (others => '0');
        input06 <= (others => '0');
        input07 <= (others => '0');
        input08 <= (others => '0');
        result1 <= (others => '0');
        result2 <= (others => '0');
        result3 <= (others => '0');
        result4 <= (others => '0');
    elsif (clk'event and clk = '1') then
        coeff01 <= coeff01_nxt;
        coeff02 <= coeff02_nxt;
        coeff03 <= coeff03_nxt;
        coeff04 <= coeff04_nxt;
        coeff05 <= coeff05_nxt;
        coeff06 <= coeff06_nxt;
        coeff07 <= coeff07_nxt;
        coeff08 <= coeff08_nxt;
        coeff09 <= coeff09_nxt;
        coeff10 <= coeff10_nxt;
        coeff11 <= coeff11_nxt;
        coeff12 <= coeff12_nxt;
        coeff13 <= coeff13_nxt;
        coeff14 <= coeff14_nxt;
        coeff15 <= coeff15_nxt;
        coeff16 <= coeff16_nxt;
        coeff17 <= coeff17_nxt;
        coeff18 <= coeff18_nxt;
        coeff19 <= coeff19_nxt;
        coeff20 <= coeff20_nxt;
        coeff21 <= coeff21_nxt;
        coeff22 <= coeff22_nxt;
        coeff23 <= coeff23_nxt;
        coeff24 <= coeff24_nxt;
        coeff25 <= coeff25_nxt;
        coeff26 <= coeff26_nxt;
        coeff27 <= coeff27_nxt;
        coeff28 <= coeff28_nxt;
        coeff29 <= coeff29_nxt;
        coeff30 <= coeff30_nxt;
        coeff31 <= coeff31_nxt;
        coeff32 <= coeff32_nxt;
        input01 <= input01_nxt;
        input02 <= input02_nxt;
        input03 <= input03_nxt;
        input04 <= input04_nxt;
        input05 <= input05_nxt;
        input06 <= input06_nxt;
        input07 <= input07_nxt;
        input08 <= input08_nxt;
        result1 <= result1_nxt;
        result2 <= result2_nxt;
        result3 <= result3_nxt;
        result4 <= result4_nxt;
    end if;
end process;

store_data : process( address2op, data2op)--start_store,
begin 
        coeff01_nxt <= coeff01;
        coeff02_nxt <= coeff02;
        coeff03_nxt <= coeff03;
        coeff04_nxt <= coeff04;
        coeff05_nxt <= coeff05;
        coeff06_nxt <= coeff06;
        coeff07_nxt <= coeff07;
        coeff08_nxt <= coeff08;
        coeff09_nxt <= coeff09;
        coeff10_nxt <= coeff10;
        coeff11_nxt <= coeff11;
        coeff12_nxt <= coeff12;
        coeff13_nxt <= coeff13;
        coeff14_nxt <= coeff14;
        coeff15_nxt <= coeff15;
        coeff16_nxt <= coeff16;
        coeff17_nxt <= coeff17;
        coeff18_nxt <= coeff18;
        coeff19_nxt <= coeff19;
        coeff20_nxt <= coeff20;
        coeff21_nxt <= coeff21;
        coeff22_nxt <= coeff22;
        coeff23_nxt <= coeff23;
        coeff24_nxt <= coeff24;
        coeff25_nxt <= coeff25;
        coeff26_nxt <= coeff26;
        coeff27_nxt <= coeff27;
        coeff28_nxt <= coeff28;
        coeff29_nxt <= coeff29;
        coeff30_nxt <= coeff30;
        coeff31_nxt <= coeff31;
        coeff32_nxt <= coeff32;
        input01_nxt <= input01;
        input02_nxt <= input02;
        input03_nxt <= input03;
        input04_nxt <= input04;
        input05_nxt <= input05;
        input06_nxt <= input06;
        input07_nxt <= input07;
        input08_nxt <= input08;

        case address2op is 
            when "000001" =>  coeff01_nxt <= data2op; data2op_done <= '0';
            when "000010" =>  coeff02_nxt <= data2op; data2op_done <= '0';
            when "000011" =>  coeff03_nxt <= data2op; data2op_done <= '0';
            when "000100" =>  coeff04_nxt <= data2op; data2op_done <= '0';
            when "000101" =>  coeff05_nxt <= data2op; data2op_done <= '0';
            when "000110" =>  coeff06_nxt <= data2op; data2op_done <= '0';
            when "000111" =>  coeff07_nxt <= data2op; data2op_done <= '0';
            when "001000" =>  coeff08_nxt <= data2op; data2op_done <= '0';
            when "001001" =>  coeff09_nxt <= data2op; data2op_done <= '0';
            when "001010" =>  coeff10_nxt <= data2op; data2op_done <= '0';
            when "001011" =>  coeff11_nxt <= data2op; data2op_done <= '0';
            when "001100" =>  coeff12_nxt <= data2op; data2op_done <= '0';
            when "001101" =>  coeff13_nxt <= data2op; data2op_done <= '0';
            when "001110" =>  coeff14_nxt <= data2op; data2op_done <= '0';
            when "001111" =>  coeff15_nxt <= data2op; data2op_done <= '0';
            when "010000" =>  coeff16_nxt <= data2op; data2op_done <= '0';
            when "010001" =>  coeff17_nxt <= data2op; data2op_done <= '0';
            when "010010" =>  coeff18_nxt <= data2op; data2op_done <= '0';
            when "010011" =>  coeff19_nxt <= data2op; data2op_done <= '0';
            when "010100" =>  coeff20_nxt <= data2op; data2op_done <= '0';
            when "010101" =>  coeff21_nxt <= data2op; data2op_done <= '0';
            when "010110" =>  coeff22_nxt <= data2op; data2op_done <= '0';
            when "010111" =>  coeff23_nxt <= data2op; data2op_done <= '0';
            when "011000" =>  coeff24_nxt <= data2op; data2op_done <= '0';
            when "011001" =>  coeff25_nxt <= data2op; data2op_done <= '0';
            when "011010" =>  coeff26_nxt <= data2op; data2op_done <= '0';
            when "011011" =>  coeff27_nxt <= data2op; data2op_done <= '0';
            when "011100" =>  coeff28_nxt <= data2op; data2op_done <= '0';
            when "011101" =>  coeff29_nxt <= data2op; data2op_done <= '0';
            when "011110" =>  coeff30_nxt <= data2op; data2op_done <= '0';
            when "011111" =>  coeff31_nxt <= data2op; data2op_done <= '0';
            when "100000" =>  coeff32_nxt <= data2op; data2op_done <= '0';
                                      
            when "100001" =>  input01_nxt <= data2op; data2op_done <= '0';
            when "100010" =>  input02_nxt <= data2op; data2op_done <= '0';
            when "100011" =>  input03_nxt <= data2op; data2op_done <= '0';
            when "100100" =>  input04_nxt <= data2op; data2op_done <= '0';
            when "100101" =>  input05_nxt <= data2op; data2op_done <= '0';
            when "100110" =>  input06_nxt <= data2op; data2op_done <= '0';
            when "100111" =>  input07_nxt <= data2op; data2op_done <= '0';
            when "101000" =>  input08_nxt <= data2op; data2op_done <= '1'; 
            when others => input_test <= (others => '0'); data2op_done <= '1';
        end case;

end process; 



end Behavioral;
