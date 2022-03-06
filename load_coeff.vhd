library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;


entity load_coeff is
  Port (
     clk, reset     : in std_logic;
    
    --signal from controller to load_coeff----------------------------------
    load_en         : in std_logic;
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



    type state_type is (s_initial, s_load, s_keep, s_send);
    signal state_reg, state_nxt : state_type;

    signal counter      : std_logic_vector(4 downto 0) := (others => '0');
    signal counter_nxt  : std_logic_vector(4 downto 0) := (others => '0');
    
    signal address_reg  : std_logic_vector(3 downto 0) := (others => '0');
    signal address_nxt  : std_logic_vector(3 downto 0) := (others => '0');
    
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

    signal coeff_in     : std_logic_vector(31 downto 0);
    --signal data_in      : std_logic_vector(31 downto 0);
    signal choose       : std_logic;
    signal address      : std_logic_vector(7 downto 0);
    signal RY_ram       : std_logic;

begin
Ram_coeff: SRAM_SP_WRAPPER
port map(
    ClkxCI             => clk           ,
    CSxSI              => choose        , -- Active Low --only write in this module
    WExSI              => '0'           , -- Active Low
    AddrxDI            => address       ,
    RYxSO              => RY_ram        ,
    DataxDI            => "000000000000000000" & coeff_read,
    DataxDO            => coeff_in 
    );







--state contrl--------------------------------
process(clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
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

--state machine--------------------------------------------
process(state_reg, load_en, --s_initial, s_load, s_keep, s_send, 
        counter, address_reg, send_ctr,
        coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09, coeff10, 
        coeff11, coeff12, coeff13, coeff14,coeff15, coeff16, coeff17, coeff18, coeff19, coeff20, 
        coeff21, coeff22, coeff23, coeff24, coeff25, coeff26, coeff27, coeff28, coeff29, coeff30, 
        coeff31, coeff32
)
begin
    case state_reg is 
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
            
            if load_en = '1' then 
                state_nxt <= s_load; 
            else
                state_nxt <= s_initial;
            end if;
        
        when s_load => --load coefficients from txt to memory
            ldcoeff_done <= '0';
            counter_nxt <= counter + 1;
            choose <= '0';--write
            address <= "000" & counter;            
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
                when "0000" => address <= "0000000"; coeff01 <= coeff_in(13 downto 7); coeff05 <= coeff_in(6 downto 0); address_nxt <= "0001"; state_nxt <= s_keep;
                when "0001" => address <= "0000001"; coeff09 <= coeff_in(13 downto 7); coeff13 <= coeff_in(6 downto 0); address_nxt <= "0010"; state_nxt <= s_keep;
                when "0010" => address <= "0000010"; coeff17 <= coeff_in(13 downto 7); coeff21 <= coeff_in(6 downto 0); address_nxt <= "0011"; state_nxt <= s_keep;
                when "0011" => address <= "0000011"; coeff25 <= coeff_in(13 downto 7); coeff29 <= coeff_in(6 downto 0); address_nxt <= "0100"; state_nxt <= s_keep;
                when "0100" => address <= "0000100"; coeff02 <= coeff_in(13 downto 7); coeff06 <= coeff_in(6 downto 0); address_nxt <= "0101"; state_nxt <= s_keep;
                when "0101" => address <= "0000101"; coeff10 <= coeff_in(13 downto 7); coeff14 <= coeff_in(6 downto 0); address_nxt <= "0110"; state_nxt <= s_keep;
                when "0110" => address <= "0000110"; coeff18 <= coeff_in(13 downto 7); coeff22 <= coeff_in(6 downto 0); address_nxt <= "0111"; state_nxt <= s_keep;
                when "0111" => address <= "0000111"; coeff26 <= coeff_in(13 downto 7); coeff30 <= coeff_in(6 downto 0); address_nxt <= "1000"; state_nxt <= s_keep;
                when "1000" => address <= "0001000"; coeff03 <= coeff_in(13 downto 7); coeff07 <= coeff_in(6 downto 0); address_nxt <= "1001"; state_nxt <= s_keep;
                when "1001" => address <= "0001001"; coeff11 <= coeff_in(13 downto 7); coeff15 <= coeff_in(6 downto 0); address_nxt <= "1010"; state_nxt <= s_keep;
                when "1010" => address <= "0001010"; coeff19 <= coeff_in(13 downto 7); coeff23 <= coeff_in(6 downto 0); address_nxt <= "1011"; state_nxt <= s_keep;
                when "1011" => address <= "0001011"; coeff27 <= coeff_in(13 downto 7); coeff31 <= coeff_in(6 downto 0); address_nxt <= "1100"; state_nxt <= s_keep;
                when "1100" => address <= "0001100"; coeff04 <= coeff_in(13 downto 7); coeff08 <= coeff_in(6 downto 0); address_nxt <= "1101"; state_nxt <= s_keep;
                when "1101" => address <= "0001101"; coeff12 <= coeff_in(13 downto 7); coeff16 <= coeff_in(6 downto 0); address_nxt <= "1110"; state_nxt <= s_keep;
                when "1110" => address <= "0001110"; coeff20 <= coeff_in(13 downto 7); coeff24 <= coeff_in(6 downto 0); address_nxt <= "1111"; state_nxt <= s_keep;
                when "1111" => address <= "0001111"; coeff28 <= coeff_in(13 downto 7); coeff32 <= coeff_in(6 downto 0); address_nxt <= "0000"; state_nxt <= s_send;
                
                when others => address <= "0000000"; coeff01 <= coeff_in(13 downto 7); coeff05 <= coeff_in(6 downto 0); address_nxt <= "0001"; state_nxt <= s_keep;
                
            end case;
        
        when s_send => 
            case send_ctr is 
                when "00000" => ctrl_coeff <= "000001"; coeff <= coeff01; ldcoeff_done <= '0'; send_ctr_nxt <= "00001"; state_nxt <= s_send;
                when "00001" => ctrl_coeff <= "000010"; coeff <= coeff02; ldcoeff_done <= '0'; send_ctr_nxt <= "00010"; state_nxt <= s_send;
                when "00010" => ctrl_coeff <= "000011"; coeff <= coeff03; ldcoeff_done <= '0'; send_ctr_nxt <= "00011"; state_nxt <= s_send;
                when "00011" => ctrl_coeff <= "000100"; coeff <= coeff04; ldcoeff_done <= '0'; send_ctr_nxt <= "00100"; state_nxt <= s_send;
                when "00100" => ctrl_coeff <= "000101"; coeff <= coeff05; ldcoeff_done <= '0'; send_ctr_nxt <= "00101"; state_nxt <= s_send;
                when "00101" => ctrl_coeff <= "000110"; coeff <= coeff06; ldcoeff_done <= '0'; send_ctr_nxt <= "00110"; state_nxt <= s_send;
                when "00110" => ctrl_coeff <= "000111"; coeff <= coeff07; ldcoeff_done <= '0'; send_ctr_nxt <= "00111"; state_nxt <= s_send;
                when "00111" => ctrl_coeff <= "001000"; coeff <= coeff08; ldcoeff_done <= '0'; send_ctr_nxt <= "01000"; state_nxt <= s_send;
                when "01000" => ctrl_coeff <= "001001"; coeff <= coeff09; ldcoeff_done <= '0'; send_ctr_nxt <= "01001"; state_nxt <= s_send;
                when "01001" => ctrl_coeff <= "001010"; coeff <= coeff10; ldcoeff_done <= '0'; send_ctr_nxt <= "01010"; state_nxt <= s_send;
                when "01010" => ctrl_coeff <= "001011"; coeff <= coeff11; ldcoeff_done <= '0'; send_ctr_nxt <= "01011"; state_nxt <= s_send;
                when "01011" => ctrl_coeff <= "001100"; coeff <= coeff12; ldcoeff_done <= '0'; send_ctr_nxt <= "01100"; state_nxt <= s_send;
                when "01100" => ctrl_coeff <= "001101"; coeff <= coeff13; ldcoeff_done <= '0'; send_ctr_nxt <= "01101"; state_nxt <= s_send;
                when "01101" => ctrl_coeff <= "001110"; coeff <= coeff14; ldcoeff_done <= '0'; send_ctr_nxt <= "01110"; state_nxt <= s_send;
                when "01110" => ctrl_coeff <= "001111"; coeff <= coeff15; ldcoeff_done <= '0'; send_ctr_nxt <= "01111"; state_nxt <= s_send;
                when "01111" => ctrl_coeff <= "010000"; coeff <= coeff16; ldcoeff_done <= '0'; send_ctr_nxt <= "10000"; state_nxt <= s_send;
                when "10000" => ctrl_coeff <= "010001"; coeff <= coeff17; ldcoeff_done <= '0'; send_ctr_nxt <= "10001"; state_nxt <= s_send;
                when "10001" => ctrl_coeff <= "010010"; coeff <= coeff18; ldcoeff_done <= '0'; send_ctr_nxt <= "10010"; state_nxt <= s_send;
                when "10010" => ctrl_coeff <= "010011"; coeff <= coeff19; ldcoeff_done <= '0'; send_ctr_nxt <= "10011"; state_nxt <= s_send;
                when "10011" => ctrl_coeff <= "010100"; coeff <= coeff20; ldcoeff_done <= '0'; send_ctr_nxt <= "10100"; state_nxt <= s_send;
                when "10100" => ctrl_coeff <= "010101"; coeff <= coeff21; ldcoeff_done <= '0'; send_ctr_nxt <= "10101"; state_nxt <= s_send;
                when "10101" => ctrl_coeff <= "010110"; coeff <= coeff22; ldcoeff_done <= '0'; send_ctr_nxt <= "10110"; state_nxt <= s_send;
                when "10110" => ctrl_coeff <= "010111"; coeff <= coeff23; ldcoeff_done <= '0'; send_ctr_nxt <= "10111"; state_nxt <= s_send;
                when "10111" => ctrl_coeff <= "011000"; coeff <= coeff24; ldcoeff_done <= '0'; send_ctr_nxt <= "11000"; state_nxt <= s_send;
                when "11000" => ctrl_coeff <= "011001"; coeff <= coeff25; ldcoeff_done <= '0'; send_ctr_nxt <= "11001"; state_nxt <= s_send;
                when "11001" => ctrl_coeff <= "011010"; coeff <= coeff26; ldcoeff_done <= '0'; send_ctr_nxt <= "11010"; state_nxt <= s_send;
                when "11010" => ctrl_coeff <= "011011"; coeff <= coeff27; ldcoeff_done <= '0'; send_ctr_nxt <= "11011"; state_nxt <= s_send;
                when "11011" => ctrl_coeff <= "011100"; coeff <= coeff28; ldcoeff_done <= '0'; send_ctr_nxt <= "11100"; state_nxt <= s_send;
                when "11100" => ctrl_coeff <= "011101"; coeff <= coeff29; ldcoeff_done <= '0'; send_ctr_nxt <= "11101"; state_nxt <= s_send;
                when "11101" => ctrl_coeff <= "011110"; coeff <= coeff30; ldcoeff_done <= '0'; send_ctr_nxt <= "11110"; state_nxt <= s_send;
                when "11110" => ctrl_coeff <= "011111"; coeff <= coeff31; ldcoeff_done <= '0'; send_ctr_nxt <= "11111"; state_nxt <= s_send;
                when "11111" => ctrl_coeff <= "100000"; coeff <= coeff32; ldcoeff_done <= '1'; send_ctr_nxt <= "00000"; state_nxt <= s_initial;   
                
                when others => ctrl_coeff <= "000001"; coeff <= coeff01; ldcoeff_done <= '0'; send_ctr_nxt <= "00001"; state_nxt <= s_send;
                      
            end case;

    end case;

end process;


end Behavioral;
