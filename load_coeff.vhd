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

--state machine--------------------------------------------
--, ldcoeff_enable, address_reg, send_ctr
process(state_reg, counter, ldcoeff_enable, address_reg, send_ctr)
begin
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
                when "00000" => address <= "00000000"; address_nxt <= "00001"; state_nxt <= s_keep;
                when "00001" => address <= "00000001";  address_nxt <= "00010"; state_nxt <= s_keep;
                when "00010" => address <= "00000010"; coeff01 <= coeff_in(13 downto 7); coeff05 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00011" => address <= "00000011"; coeff09 <= coeff_in(13 downto 7); coeff13 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00100" => address <= "00000100"; coeff17 <= coeff_in(13 downto 7); coeff21 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00101" => address <= "00000101"; coeff25 <= coeff_in(13 downto 7); coeff29 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00110" => address <= "00000110"; coeff02 <= coeff_in(13 downto 7); coeff06 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "00111" => address <= "00000111"; coeff10 <= coeff_in(13 downto 7); coeff14 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01000" => address <= "00001000"; coeff18 <= coeff_in(13 downto 7); coeff22 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01001" => address <= "00001001"; coeff26 <= coeff_in(13 downto 7); coeff30 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01010" => address <= "00001010"; coeff03 <= coeff_in(13 downto 7); coeff07 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01011" => address <= "00001011"; coeff11 <= coeff_in(13 downto 7); coeff15 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01100" => address <= "00001100"; coeff19 <= coeff_in(13 downto 7); coeff23 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01101" => address <= "00001101"; coeff27 <= coeff_in(13 downto 7); coeff31 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01110" => address <= "00001110"; coeff04 <= coeff_in(13 downto 7); coeff08 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "01111" => address <= "00001111"; coeff12 <= coeff_in(13 downto 7); coeff16 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "10000" => coeff20 <= coeff_in(13 downto 7); coeff24 <= coeff_in(6 downto 0); address_nxt <= address_reg + 1; state_nxt <= s_keep;
                when "10001" => coeff28 <= coeff_in(13 downto 7); coeff32 <= coeff_in(6 downto 0); address_nxt <= "00000";state_nxt <= s_send;
                when others => address <= "00000000"; state_nxt <= s_keep;
                
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
