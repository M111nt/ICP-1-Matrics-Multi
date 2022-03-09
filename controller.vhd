
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity controller is
    Port ( 
        clk, reset      : in std_logic;
        ldcoeff_done    : in std_logic;
        ldinput_done    : in std_logic; 
        start           : in std_logic; 
        load_done       : in std_logic; 
        op_done         : in std_logic;
        store_done      : in std_logic;
    --ld coeff--------------------------------------------------------------       
        ctrl_coeff      : in std_logic_vector(5 downto 0);
        coeff           : in std_logic_vector(6 downto 0);
    --ld input--------------------------------------------------------------
        ctrl_input      : in std_logic_vector(3 downto 0);
        input           : in std_logic_vector(7 downto 0);
    --number from op---------------------------------------------------------    
        --data2op_done    : in std_logic; --finish storing data in op

        --out_ready       : in std_logic; --return 4 results to controller
        result1         : in std_logic_vector(18 downto 0);
        result2         : in std_logic_vector(18 downto 0);
        result3         : in std_logic_vector(18 downto 0);
        result4         : in std_logic_vector(18 downto 0);    
        
------------------------------------------------------------------------        
        
        ldcoeff_enable  : out std_logic;
        ldinput_enable  : out std_logic; 
        load_en         : out std_logic;
        op_en           : out std_logic;
        store_en        : out std_logic; 
        --ready           : out std_logic; 
        max_en          : out std_logic;
        avg_en          : out std_logic;   

    --ld coeff--------------------------------------------------------------       
        --flag_coeff      : out std_logic; 
    --ld input--------------------------------------------------------------
        --flag_input      : out std_logic;
        column_out        : out std_logic_vector(1 downto 0);
    --number to op----------------------------------------------------------    
        --begin_coeff2op  : out std_logic;
        --flag_coeff2op   : out std_logic;
        --flag_data2op   : out std_logic;
        data2op         : out std_logic_vector(7 downto 0);
        --begin_input2op  : out std_logic;
        --input2op        : out std_logic_vector(7 downto 0)
        address2op      : out std_logic_vector(5 downto 0);
    ----------------------------------------------------------------
        result1_2store  : out std_logic_vector(18 downto 0);
        result2_2store  : out std_logic_vector(18 downto 0);
        result3_2store  : out std_logic_vector(18 downto 0);
        result4_2store  : out std_logic_vector(18 downto 0)
        --mean_out        : out std_logic_vector(20 downto 0)  
    );

end controller;


architecture Behavioral of controller is

    signal ldcoeff_controller   : std_logic;
    signal ldinput_controller   : std_logic;
    signal op_controller        : std_logic;

--state machine----------------------------------------------------
    --signal column : std_logic_vector(2 downto 0);

    type state_type is (s_coeff2mem, s_input2reg, s_idle, s_load, s_op, s_store, s_max, s_avg);
    signal state_reg, state_nxt : state_type;
    
--load coeff-------------------------------------------------    
    signal coeff_test   :std_logic_vector (6 downto 0);

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
    
    signal coeff01_nxt  : std_logic_vector(6 downto 0);
    signal coeff02_nxt  : std_logic_vector(6 downto 0);
    signal coeff03_nxt  : std_logic_vector(6 downto 0);
    signal coeff04_nxt  : std_logic_vector(6 downto 0);
    signal coeff05_nxt  : std_logic_vector(6 downto 0);
    signal coeff06_nxt  : std_logic_vector(6 downto 0);
    signal coeff07_nxt  : std_logic_vector(6 downto 0);
    signal coeff08_nxt  : std_logic_vector(6 downto 0);
    signal coeff09_nxt  : std_logic_vector(6 downto 0);
    signal coeff10_nxt  : std_logic_vector(6 downto 0);
    signal coeff11_nxt  : std_logic_vector(6 downto 0);
    signal coeff12_nxt  : std_logic_vector(6 downto 0);
    signal coeff13_nxt  : std_logic_vector(6 downto 0);
    signal coeff14_nxt  : std_logic_vector(6 downto 0);
    signal coeff15_nxt  : std_logic_vector(6 downto 0);
    signal coeff16_nxt  : std_logic_vector(6 downto 0);
    signal coeff17_nxt  : std_logic_vector(6 downto 0);
    signal coeff18_nxt  : std_logic_vector(6 downto 0);
    signal coeff19_nxt  : std_logic_vector(6 downto 0);
    signal coeff20_nxt  : std_logic_vector(6 downto 0);
    signal coeff21_nxt  : std_logic_vector(6 downto 0);
    signal coeff22_nxt  : std_logic_vector(6 downto 0);
    signal coeff23_nxt  : std_logic_vector(6 downto 0);
    signal coeff24_nxt  : std_logic_vector(6 downto 0);
    signal coeff25_nxt  : std_logic_vector(6 downto 0);
    signal coeff26_nxt  : std_logic_vector(6 downto 0);
    signal coeff27_nxt  : std_logic_vector(6 downto 0);
    signal coeff28_nxt  : std_logic_vector(6 downto 0);
    signal coeff29_nxt  : std_logic_vector(6 downto 0);
    signal coeff30_nxt  : std_logic_vector(6 downto 0);
    signal coeff31_nxt  : std_logic_vector(6 downto 0);
    signal coeff32_nxt  : std_logic_vector(6 downto 0);
    
--ld input-------------------------------------------------------------
    signal input_test   : std_logic_vector(7 downto 0);
    
    signal input01      : std_logic_vector(7 downto 0);
    signal input02      : std_logic_vector(7 downto 0);
    signal input03      : std_logic_vector(7 downto 0);
    signal input04      : std_logic_vector(7 downto 0);
    signal input05      : std_logic_vector(7 downto 0);
    signal input06      : std_logic_vector(7 downto 0);
    signal input07      : std_logic_vector(7 downto 0);
    signal input08      : std_logic_vector(7 downto 0);
    
    signal input01_nxt  : std_logic_vector(7 downto 0);
    signal input02_nxt  : std_logic_vector(7 downto 0);
    signal input03_nxt  : std_logic_vector(7 downto 0);
    signal input04_nxt  : std_logic_vector(7 downto 0);
    signal input05_nxt  : std_logic_vector(7 downto 0);
    signal input06_nxt  : std_logic_vector(7 downto 0);
    signal input07_nxt  : std_logic_vector(7 downto 0);
    signal input08_nxt  : std_logic_vector(7 downto 0);

--op counter------------------------------------------------------------
    signal counter, counter_nxt   : std_logic_vector(5 downto 0); 
    --signal counter_in, counter_in_nxt   : std_logic_vector(3 downto 0);
    signal start_count                  : std_logic;
    --signal op_en_in                     : std_logic;
--store data-------------------------------------------------------------
    signal column       : std_logic_vector(1 downto 0);
    signal column_nxt   : std_logic_vector(1 downto 0);
    
    --signal column_ctrl  : std_logic;
    signal result1_reg  : std_logic_vector(18 downto 0);
    signal result2_reg  : std_logic_vector(18 downto 0);
    signal result3_reg  : std_logic_vector(18 downto 0);
    signal result4_reg  : std_logic_vector(18 downto 0);
    
    
    
    
    signal mean1    : std_logic_vector(18 downto 0);
    signal mean2    : std_logic_vector(18 downto 0);
    signal mean3    : std_logic_vector(18 downto 0);
    signal mean4    : std_logic_vector(18 downto 0);
    
--mean--------------------------------------------------------------------

    signal mean_reg : std_logic_vector(20 downto 0);
    signal mean_out : std_logic_vector(20 downto 0);    
    
------------------------------------------------------------------------
begin

--state ctrl-----------------------------------
process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_coeff2mem; 
        --column <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        --column <= column_nxt;
    end if;         
end process;

--state machine-------------------------------------
state_machine:process (state_reg, start, 
        ldcoeff_done, ldinput_done, load_done, op_done, store_done, 
        column, column_nxt, 
        result1_reg, result2_reg, result3_reg, result4_reg, 
        mean1, mean2, mean3, mean4, mean_reg
        )
begin
    ldinput_enable <= '0';
    load_en <= '0';
    op_en <= '0';
    store_en <= '0';
    max_en <= '0';
    avg_en <= '0'; 
    result1_2store <= (others => '0');
    result2_2store <= (others => '0');
    result3_2store <= (others => '0');
    result4_2store <= (others => '0');
    ldcoeff_controller <= '1';
    ldinput_controller <= '1';
    op_controller <= '0';
    result1_reg <= (others => '0');
    result2_reg <= (others => '0');
    result3_reg <= (others => '0');
    result4_reg <= (others => '0');
    column_out <= (others => '0');
    --column_nxt <= column;



    case state_reg is 
        when s_coeff2mem => 
--            ldcoeff_enable <= '1'; 
--            ldcoeff_controller <= '1';
            ldinput_enable <= '0'; 
            --column <= "00";
            column_nxt <= "00";
            if ldcoeff_done = '1' then 
                state_nxt <= s_input2reg;
            else 
                ldcoeff_enable <= '1'; 
                ldcoeff_controller <= '1';
                state_nxt <= s_coeff2mem;
            end if;
            
        when s_input2reg =>
            ldcoeff_enable <= '0';
            ldcoeff_controller <= '0';
            ldinput_enable <= '1'; 
            column <= column_nxt;
            --control the result of mean         
            if ldinput_done = '1' then 
                state_nxt <= s_idle;
            else
                state_nxt <= s_input2reg;
            end if;
        
        when s_idle => 
            load_en <= '0';
            ldinput_controller <= '0';
            op_en <= '0';
            store_en <= '0';
            max_en <= '0';
            avg_en <= '0';
            if start = '1' then 
                state_nxt <= s_load; 
            else
                state_nxt <= state_reg;
            end if;
            
        when s_load => 
            load_en <= '1'; 
            ldinput_controller <= '1';
            column <= column_nxt;
            column_out <= column_nxt;
            op_en <= '0'; 
            op_controller <= '0';  
            store_en <= '0';
            max_en <= '0';
            avg_en <= '0';
            if load_done = '1' then
                state_nxt <= s_op;
            else
                state_nxt <= s_load; 
            end if;            
        
        when s_op => 
            load_en <= '0'; 
            ldinput_controller <= '0';
            op_en <= '1'; 
            op_controller <= '1';  
            store_en <= '0';
            max_en <= '0';
            avg_en <= '0';
            if op_done = '1' then
                state_nxt <= s_store;
            else 
                state_nxt <= s_op; 
            end if;
                               
        when s_store => 
            load_en <= '0'; 
            op_en <= '0'; 
            op_controller <= '0';   
            store_en <= '1';
            max_en <= '0';
            avg_en <= '0';
            --if out_ready = '1' then 
            result1_reg <= result1;
            result2_reg <= result2;
            result3_reg <= result3;
            result4_reg <= result4;

                case column is 
                    when "00" =>
                        mean1 <= result1_reg;
                        result1_2store <= result1_reg;
                        result2_2store <= result2_reg;
                        result3_2store <= result3_reg;
                        result4_2store <= result4_reg;
                        if store_done = '1' then
                            state_nxt <= s_load;
                            column_nxt <= column + 1;
                        else 
                            state_nxt <= s_store; 
                        end if;

                    when "01" =>
                        mean2 <= result2_reg; 
                        result1_2store <= result1_reg;
                        result2_2store <= result2_reg;
                        result3_2store <= result3_reg;
                        result4_2store <= result4_reg;
                        if store_done = '1' then
                            state_nxt <= s_load;
                            column_nxt <= column + 1;
                        else 
                            state_nxt <= s_store; 
                        end if;
                    when "10" =>
                        mean3 <= result3_reg;
                        result1_2store <= result1_reg;
                        result2_2store <= result2_reg;
                        result3_2store <= result3_reg;
                        result4_2store <= result4_reg;
                        if store_done = '1' then
                            state_nxt <= s_load;
                            column_nxt <= column + 1;
                        else 
                            state_nxt <= s_store; 
                        end if;
                    when "11" =>
                        mean4 <= result4_reg;
                        result1_2store <= result1_reg;
                        result2_2store <= result2_reg;
                        result3_2store <= result3_reg;
                        result4_2store <= result4_reg;
                        if store_done = '1' then
                            state_nxt <= s_max;
                            column_nxt <= "00";
                        else 
                            state_nxt <= s_store;
                        end if; 
                        
                     when others => state_nxt <= s_store;   
                end case;
--            else
--                result1_2store <= (others => '0');
--                result2_2store <= (others => '0');
--                result3_2store <= (others => '0');
--                result4_2store <= (others => '0');
--            end if;
            

        
        when s_max => 
            load_en <= '0'; 
            op_en <= '0';   
            store_en <= '0';
            avg_en <= '0';
            max_en <= '1';
            state_nxt <= s_avg; 
                        
        when s_avg => 
            load_en <= '0'; 
            op_en <= '0';   
            store_en <= '0';
            max_en <= '0';
            avg_en <= '1';
            mean_reg <= mean1 + mean2 + mean3 + mean4 + std_logic_vector(to_unsigned(0,21)); 
            mean_out <= "00" & mean_reg(20 downto 2);
            state_nxt <= s_input2reg;
    end case;
    
end process;

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

    end if;

end process;


--load coeff-----------------------------------------------------
ld_coeff: process(ldcoeff_controller, ctrl_coeff, coeff)
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

    if ldcoeff_controller = '1' then 
        case ctrl_coeff is 
            when "000001" => coeff01_nxt <= coeff; --flag_coeff <= '0'; --start, parity
            when "000010" => coeff02_nxt <= coeff; --flag_coeff <= '0';
            when "000011" => coeff03_nxt <= coeff; --flag_coeff <= '0';
            when "000100" => coeff04_nxt <= coeff; --flag_coeff <= '0';
            when "000101" => coeff05_nxt <= coeff; --flag_coeff <= '0';
            when "000110" => coeff06_nxt <= coeff; --flag_coeff <= '0';
            when "000111" => coeff07_nxt <= coeff; --flag_coeff <= '0';
            when "001000" => coeff08_nxt <= coeff; --flag_coeff <= '0';
            when "001001" => coeff09_nxt <= coeff; --flag_coeff <= '0';
            when "001010" => coeff10_nxt <= coeff; --flag_coeff <= '0';
            when "001011" => coeff11_nxt <= coeff; --flag_coeff <= '0';
            when "001100" => coeff12_nxt <= coeff; --flag_coeff <= '0';
            when "001101" => coeff13_nxt <= coeff; --flag_coeff <= '0';
            when "001110" => coeff14_nxt <= coeff; --flag_coeff <= '0';
            when "001111" => coeff15_nxt <= coeff; --flag_coeff <= '0';
            when "010000" => coeff16_nxt <= coeff; --flag_coeff <= '0';
            when "010001" => coeff17_nxt <= coeff; --flag_coeff <= '0';
            when "010010" => coeff18_nxt <= coeff; --flag_coeff <= '0';
            when "010011" => coeff19_nxt <= coeff; --flag_coeff <= '0';
            when "010100" => coeff20_nxt <= coeff; --flag_coeff <= '0';
            when "010101" => coeff21_nxt <= coeff; --flag_coeff <= '0';
            when "010110" => coeff22_nxt <= coeff; --flag_coeff <= '0';
            when "010111" => coeff23_nxt <= coeff; --flag_coeff <= '0';
            when "011000" => coeff24_nxt <= coeff; --flag_coeff <= '0';
            when "011001" => coeff25_nxt <= coeff; --flag_coeff <= '0';
            when "011010" => coeff26_nxt <= coeff; --flag_coeff <= '0';
            when "011011" => coeff27_nxt <= coeff; --flag_coeff <= '0';
            when "011100" => coeff28_nxt <= coeff; --flag_coeff <= '0';
            when "011101" => coeff29_nxt <= coeff; --flag_coeff <= '0';
            when "011110" => coeff30_nxt <= coeff; --flag_coeff <= '0';
            when "011111" => coeff31_nxt <= coeff; --flag_coeff <= '0';
            when "100000" => coeff32_nxt <= coeff; --flag_coeff <= '1';
            when others => coeff_test <= (others => '0');--flag_coeff <= '1';
        end case;
    else 
        coeff_test <= (others => '0');
        --flag_coeff <= '0';
    end if;
       
end process;


--load input-----------------------------------------------------
ld_input: process(ldinput_controller, ctrl_input, input)
begin 
    input01_nxt <= input01;
    input02_nxt <= input02;
    input03_nxt <= input03;
    input04_nxt <= input04;
    input05_nxt <= input05;
    input06_nxt <= input06;
    input07_nxt <= input07;
    input08_nxt <= input08;
    
    if ldinput_controller = '1' then 
        case ctrl_input is
            when "0001" => input01_nxt <= input; --flag_input <= '0';
            when "0010" => input02_nxt <= input; --flag_input <= '0';
            when "0011" => input03_nxt <= input; --flag_input <= '0';
            when "0100" => input04_nxt <= input; --flag_input <= '0';
            when "0101" => input05_nxt <= input; --flag_input <= '0';
            when "0110" => input06_nxt <= input; --flag_input <= '0';
            when "0111" => input07_nxt <= input; --flag_input <= '0';
            when "1000" => input08_nxt <= input; --flag_input <= '1';
            when others => input_test <= (others =>'0'); --flag_input <= '1';
        end case;
    else 
        input_test <= (others => '0'); 
        --flag_input <= '0'; 
    end if;

end process;

--op send data----------------------------------------------------------------------
op_counter : process(clk, reset, start_count, counter_nxt)-- counter_in_nxt
begin 
    if reset = '1' then 
        counter <= "000001"; 
    elsif (clk'event and clk = '1') then 
        if start_count = '1' then 
            counter <= counter_nxt; 
        else 
            counter <= "000001"; 
        end if; 
    end if;         

end process;

op_send: process(op_controller, counter, --data2op_done,
                coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09, coeff10, 
                coeff11, coeff12, coeff13, coeff14,coeff15, coeff16, coeff17, coeff18, coeff19, coeff20, 
                coeff21, coeff22, coeff23, coeff24, coeff25, coeff26, coeff27, coeff28, coeff29, coeff30, 
                coeff31, coeff32, 
                input01, input02, input03, input04, input05, input06, input07, input08)
begin 
    --counter_nxt <= counter;
    address2op <= "000001";
    data2op <= (others => '0');
    counter_nxt <= "000001";
    if op_controller ='1' then 
        start_count <= '1'; --contrl the op counter
--        if data2op_done = '0' then
--            flag_data2op <= '0';
            case counter is 
                when "000001" => data2op <= "0" & coeff01; counter_nxt <= counter + "000001"; address2op <= "000001";
                when "000010" => data2op <= "0" & coeff02; counter_nxt <= counter + "000001"; address2op <= "000010";
                when "000011" => data2op <= "0" & coeff03; counter_nxt <= counter + "000001"; address2op <= "000011";
                when "000100" => data2op <= "0" & coeff04; counter_nxt <= counter + "000001"; address2op <= "000100";
                when "000101" => data2op <= "0" & coeff05; counter_nxt <= counter + "000001"; address2op <= "000101";
                when "000110" => data2op <= "0" & coeff06; counter_nxt <= counter + "000001"; address2op <= "000110";
                when "000111" => data2op <= "0" & coeff07; counter_nxt <= counter + "000001"; address2op <= "000111";
                when "001000" => data2op <= "0" & coeff08; counter_nxt <= counter + "000001"; address2op <= "001000";
                when "001001" => data2op <= "0" & coeff09; counter_nxt <= counter + "000001"; address2op <= "001001";
                when "001010" => data2op <= "0" & coeff10; counter_nxt <= counter + "000001"; address2op <= "001010";
                when "001011" => data2op <= "0" & coeff11; counter_nxt <= counter + "000001"; address2op <= "001011";
                when "001100" => data2op <= "0" & coeff12; counter_nxt <= counter + "000001"; address2op <= "001100";
                when "001101" => data2op <= "0" & coeff13; counter_nxt <= counter + "000001"; address2op <= "001101";
                when "001110" => data2op <= "0" & coeff14; counter_nxt <= counter + "000001"; address2op <= "001110";
                when "001111" => data2op <= "0" & coeff15; counter_nxt <= counter + "000001"; address2op <= "001111";
                when "010000" => data2op <= "0" & coeff16; counter_nxt <= counter + "000001"; address2op <= "010000";
                when "010001" => data2op <= "0" & coeff17; counter_nxt <= counter + "000001"; address2op <= "010001";
                when "010010" => data2op <= "0" & coeff18; counter_nxt <= counter + "000001"; address2op <= "010010";
                when "010011" => data2op <= "0" & coeff19; counter_nxt <= counter + "000001"; address2op <= "010011";
                when "010100" => data2op <= "0" & coeff20; counter_nxt <= counter + "000001"; address2op <= "010100";
                when "010101" => data2op <= "0" & coeff21; counter_nxt <= counter + "000001"; address2op <= "010101";
                when "010110" => data2op <= "0" & coeff22; counter_nxt <= counter + "000001"; address2op <= "010110";
                when "010111" => data2op <= "0" & coeff23; counter_nxt <= counter + "000001"; address2op <= "010111";
                when "011000" => data2op <= "0" & coeff24; counter_nxt <= counter + "000001"; address2op <= "011000";
                when "011001" => data2op <= "0" & coeff25; counter_nxt <= counter + "000001"; address2op <= "011001";
                when "011010" => data2op <= "0" & coeff26; counter_nxt <= counter + "000001"; address2op <= "011010";
                when "011011" => data2op <= "0" & coeff27; counter_nxt <= counter + "000001"; address2op <= "011011";
                when "011100" => data2op <= "0" & coeff28; counter_nxt <= counter + "000001"; address2op <= "011100";
                when "011101" => data2op <= "0" & coeff29; counter_nxt <= counter + "000001"; address2op <= "011101";
                when "011110" => data2op <= "0" & coeff30; counter_nxt <= counter + "000001"; address2op <= "011110";
                when "011111" => data2op <= "0" & coeff31; counter_nxt <= counter + "000001"; address2op <= "011111";
                when "100000" => data2op <= "0" & coeff32; counter_nxt <= counter + "000001"; address2op <= "100000";
               
                when "100001" => data2op <= input01; counter_nxt <= counter + "000001"; address2op <= "100001";
                when "100010" => data2op <= input02; counter_nxt <= counter + "000001"; address2op <= "100010";
                when "100011" => data2op <= input03; counter_nxt <= counter + "000001"; address2op <= "100011";
                when "100100" => data2op <= input04; counter_nxt <= counter + "000001"; address2op <= "100100";
                when "100101" => data2op <= input05; counter_nxt <= counter + "000001"; address2op <= "100101";
                when "100110" => data2op <= input06; counter_nxt <= counter + "000001"; address2op <= "100110";
                when "100111" => data2op <= input07; counter_nxt <= counter + "000001"; address2op <= "100111";
                when "101000" => data2op <= input08; counter_nxt <= "000001"; address2op <= "101000"; 
                when others => data2op <= (others => '0'); counter_nxt <= "000001"; address2op <= "000001";        
            end case;
--        else 
            --data2op <= (others => '0'); 
--            counter_nxt <= "000001";
--            flag_data2op <= '1';
--            address2op <= "000001";
--        end if;
    else 
        --begin_coeff2op <= '0';
        --begin_input2op <= '0';
        start_count <= '0';  
    end if;

end process;





--------------------------------------------------------------------------------------------------------------------------------------------------


end Behavioral;




