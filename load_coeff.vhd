library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;


entity load_coeff is
  Port (
     clk, reset     : in std_logic;
    
    --signal from controller to load_coeff----------------------------------
    ldcoeff_enable  : in std_logic;
    --coeff from memory-----------------------------------------------------
    --coeff_in        : in std_logic_vector(31 downto 0);
    coeff_read      : in std_logic_vector(13 downto 0);
    
    --enable txt file to memory---------------------------------------------
    ld2mem          : out std_logic;
    --to memory-------------------------------------------------------------
    --address         : out std_logic_vector(7 downto 0);
    --to controller---------------------------------------------------------
    ctrl_coeff      : out std_logic_vector(5 downto 0);
    coeff           : out std_logic_vector(6 downto 0);
    ldcoeff_done    : out std_logic

  );
end load_coeff;

architecture Behavioral of load_coeff is

component SRAM_SP_WRAPPER
  port (
    ClkxCI  : in  std_logic;
    CSxSI   : in  std_logic;            -- Active Low
    WExSI   : in  std_logic;            --Active Low
    AddrxDI : in  std_logic_vector (7 downto 0);
    RYxSO   : out std_logic;
    DataxDI : in  std_logic_vector (31 downto 0);
    DataxDO : out std_logic_vector (31 downto 0)
    );
end component;



    type state_type is (s_idle, s_initial, s_load, s_keep, s_send);
    signal state_reg, state_nxt : state_type;

    signal counter      : std_logic_vector(4 downto 0) := (others => '0');
    signal counter_nxt  : std_logic_vector(4 downto 0) := (others => '0');
    
    signal address_reg  : std_logic_vector(4 downto 0) := (others => '0');
    signal address_nxt  : std_logic_vector(4 downto 0) := (others => '0');
    
    signal send_ctr     : std_logic_vector(4 downto 0) := (others => '0');
    signal send_ctr_nxt : std_logic_vector(4 downto 0) := (others => '0');

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

    signal coeff_in     : std_logic_vector(31 downto 0);
    --signal data_in      : std_logic_vector(31 downto 0);
    signal choose       : std_logic;
    signal address      : std_logic_vector(7 downto 0);
    signal RY_ram       : std_logic;
    signal dataxdi      : std_logic_vector(31 downto 0);

begin
Ram_coeff: SRAM_SP_WRAPPER
port map(
    ClkxCI             => clk           ,
    CSxSI              => '0'        , -- Active Low --only write in this module
    WExSI              => choose           , -- Active Low
    AddrxDI            => address       ,
    RYxSO              => RY_ram        ,
    DataxDI            => dataxdi       ,
    DataxDO            => coeff_in 
    );

--dataxdi <= "000000000000000000" & coeff_read;





--state contrl--------------------------------
process(clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_idle; 
        counter <= (others => '0');
        address_reg <= (others => '0');
        send_ctr <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 

        counter <= counter_nxt;
        address_reg <= address_nxt;
        send_ctr <= send_ctr_nxt;
    end if;

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
    end if;

end process;

--state machine--------------------------------------------
--, ldcoeff_enable, address_reg, send_ctr
process(state_reg, counter, ldcoeff_enable, address_reg, send_ctr)
begin
    choose <= '1';
    dataxdi <= (others => '0');
    address <= (others => '0');
    ld2mem <= '0';
    ctrl_coeff <= (others => '0');
    coeff <= (others => '0');
    ldcoeff_done <= '0';
    counter_nxt <= (others => '0'); 
    address_nxt <= (others => '0');
    send_ctr_nxt <= send_ctr;
    
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

    case state_reg is 
        when s_idle =>
            state_nxt <= s_initial;
        when s_initial => 
            ctrl_coeff <= (others => '0');      
            coeff <= (others => '0'); 
            ldcoeff_done <= '0'; 
            ld2mem <= '0';
            counter_nxt <= (others => '0');
            address <= (others => '0');
            
            --address_reg <= (others => '0');
            address_nxt <= (others => '0');
            send_ctr_nxt <= (others => '0');
            
            if ldcoeff_enable = '1' then 
                state_nxt <= s_load; 
            else
                state_nxt <= s_initial;
            end if;
        
        when s_load => --load coefficients from txt to memory
            ldcoeff_done <= '0';
            counter_nxt <= counter + 1;
            choose <= '0';--write
            address <= "000" & counter;
            dataxdi <= "000000000000000000" & coeff_read;            
            if counter > 15 then
                state_nxt <= s_keep;
                ld2mem <= '0';
            else 
                state_nxt <= s_load;
                ld2mem <= '1';
            end if;
            
        when s_keep =>  
        choose <= '1';--read
            case address_reg is 
                when "00000" => address <= "00000000"; address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00001" => address <= "00000001";  address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00010" => address <= "00000010"; coeff01_nxt <= coeff_in(13 downto 7); coeff05_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00011" => address <= "00000011"; coeff09_nxt <= coeff_in(13 downto 7); coeff13_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00100" => address <= "00000100"; coeff17_nxt <= coeff_in(13 downto 7); coeff21_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00101" => address <= "00000101"; coeff25_nxt <= coeff_in(13 downto 7); coeff29_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00110" => address <= "00000110"; coeff02_nxt <= coeff_in(13 downto 7); coeff06_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00111" => address <= "00000111"; coeff10_nxt <= coeff_in(13 downto 7); coeff14_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01000" => address <= "00001000"; coeff18_nxt <= coeff_in(13 downto 7); coeff22_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01001" => address <= "00001001"; coeff26_nxt <= coeff_in(13 downto 7); coeff30_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01010" => address <= "00001010"; coeff03_nxt <= coeff_in(13 downto 7); coeff07_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01011" => address <= "00001011"; coeff11_nxt <= coeff_in(13 downto 7); coeff15_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01100" => address <= "00001100"; coeff19_nxt <= coeff_in(13 downto 7); coeff23_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01101" => address <= "00001101"; coeff27_nxt <= coeff_in(13 downto 7); coeff31_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01110" => address <= "00001110"; coeff04_nxt <= coeff_in(13 downto 7); coeff08_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01111" => address <= "00001111"; coeff12_nxt <= coeff_in(13 downto 7); coeff16_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "10000" => coeff20_nxt <= coeff_in(13 downto 7); coeff24_nxt <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "10001" => coeff28_nxt <= coeff_in(13 downto 7); coeff32_nxt <= coeff_in(6 downto 0); address_nxt <= (others => '0');state_nxt <= s_send;
                when others => address <= "00000000"; state_nxt <= s_keep;
                
            end case;
        
        when s_send => 
            case send_ctr is 
                when "00000" => ctrl_coeff <= "000001"; coeff <= coeff01; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00001" => ctrl_coeff <= "000010"; coeff <= coeff02; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00010" => ctrl_coeff <= "000011"; coeff <= coeff03; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00011" => ctrl_coeff <= "000100"; coeff <= coeff04; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00100" => ctrl_coeff <= "000101"; coeff <= coeff05; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00101" => ctrl_coeff <= "000110"; coeff <= coeff06; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00110" => ctrl_coeff <= "000111"; coeff <= coeff07; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "00111" => ctrl_coeff <= "001000"; coeff <= coeff08; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01000" => ctrl_coeff <= "001001"; coeff <= coeff09; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01001" => ctrl_coeff <= "001010"; coeff <= coeff10; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01010" => ctrl_coeff <= "001011"; coeff <= coeff11; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01011" => ctrl_coeff <= "001100"; coeff <= coeff12; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01100" => ctrl_coeff <= "001101"; coeff <= coeff13; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01101" => ctrl_coeff <= "001110"; coeff <= coeff14; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01110" => ctrl_coeff <= "001111"; coeff <= coeff15; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "01111" => ctrl_coeff <= "010000"; coeff <= coeff16; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10000" => ctrl_coeff <= "010001"; coeff <= coeff17; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10001" => ctrl_coeff <= "010010"; coeff <= coeff18; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10010" => ctrl_coeff <= "010011"; coeff <= coeff19; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10011" => ctrl_coeff <= "010100"; coeff <= coeff20; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10100" => ctrl_coeff <= "010101"; coeff <= coeff21; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10101" => ctrl_coeff <= "010110"; coeff <= coeff22; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10110" => ctrl_coeff <= "010111"; coeff <= coeff23; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "10111" => ctrl_coeff <= "011000"; coeff <= coeff24; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11000" => ctrl_coeff <= "011001"; coeff <= coeff25; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11001" => ctrl_coeff <= "011010"; coeff <= coeff26; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11010" => ctrl_coeff <= "011011"; coeff <= coeff27; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11011" => ctrl_coeff <= "011100"; coeff <= coeff28; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11100" => ctrl_coeff <= "011101"; coeff <= coeff29; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11101" => ctrl_coeff <= "011110"; coeff <= coeff30; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11110" => ctrl_coeff <= "011111"; coeff <= coeff31; ldcoeff_done <= '0'; send_ctr_nxt <= send_ctr + 1; state_nxt <= s_send;
                when "11111" => ctrl_coeff <= "100000"; coeff <= coeff32; ldcoeff_done <= '1'; send_ctr_nxt <= "00000"; state_nxt <= s_initial;   
                
                when others => ctrl_coeff <= "000001"; coeff <= coeff01; ldcoeff_done <= '0'; send_ctr_nxt <= "00001"; state_nxt <= s_send;
                      
            end case;

    end case;

end process;


end Behavioral;
