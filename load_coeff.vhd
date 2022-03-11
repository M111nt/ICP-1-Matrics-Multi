library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;


entity load_coeff is
  Port (
     clk, reset     : in std_logic;
    
    ldcoeff_enable  : in std_logic;
    --coeff from memory-----------------------------------------------------
    coeff_read      : in std_logic_vector(13 downto 0);
    
    --enable txt file to memory---------------------------------------------
    ld2mem          : out std_logic;
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

component ff is
  generic(N:integer:=1);
  port(   D  :  in std_logic_vector(N-1 downto 0);
          Q  : out std_logic_vector(N-1 downto 0);
        clk  :  in std_logic;
        reset:  in std_logic
      );
end component;

    type state_type is (s_initial, s_load, s_keep, s_send);
    signal state_reg, state_nxt : state_type;

    signal counter      : std_logic_vector(4 downto 0) := (others => '0');
    signal counter_nxt  : std_logic_vector(4 downto 0) := (others => '0');
    signal counter_2    : std_logic_vector(4 downto 0) := (others => '0');
    signal counter_2_nxt: std_logic_vector(4 downto 0) := (others => '0');
    
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
    signal start_store  : std_logic;
    
    signal coeff_in     : std_logic_vector(31 downto 0);
    signal choose       : std_logic;
    signal address      : std_logic_vector(7 downto 0);
    signal address_out  : std_logic_vector(7 downto 0);
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

--state contrl--------------------------------
process(clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        send_ctr <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        send_ctr <= send_ctr_nxt;
    end if;

end process;


--state machine--------------------------------------------
process(state_reg, counter, ldcoeff_enable, send_ctr, counter_2)
begin
    choose <= '1';
    dataxdi <= (others => '0');
    address <= (others => '0');
    ld2mem <= '0';
    ctrl_coeff <= (others => '0');
    coeff <= (others => '0');
    ldcoeff_done <= '0';
    counter_nxt <= (others => '0'); 
    counter_2_nxt <= (others => '0');
 
    send_ctr_nxt <= send_ctr;
    

    address <= (others => '0');
    
    start_store <= '0';

    case state_reg is 
        when s_initial => 
            ctrl_coeff <= (others => '0');      
            coeff <= (others => '0'); 
            ldcoeff_done <= '0'; 
            ld2mem <= '0';
            counter_nxt <= (others => '0');
            send_ctr_nxt <= (others => '0');
            
            if ldcoeff_enable = '1' then 
                state_nxt <= s_load; 
            else
                state_nxt <= s_initial;
            end if;
        
        when s_load => --load coefficients from txt to memory
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
        address <= "000" & counter_2;
        counter_2_nxt <= counter_2 + 1;
        if counter_2 > 15 then 
            state_nxt <= s_send;
        else 
            state_nxt <= s_keep;
        end if;
        
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

coeff01_nxt <= coeff_in(13 downto 7)    when counter_2 = "00001" else coeff01; 
coeff05_nxt <= coeff_in(6 downto 0)     when counter_2 = "00001" else coeff05;
coeff09_nxt <= coeff_in(13 downto 7)    when counter_2 = "00010" else coeff09; 
coeff13_nxt <= coeff_in(6 downto 0)     when counter_2 = "00010" else coeff13;
coeff17_nxt <= coeff_in(13 downto 7)    when counter_2 = "00011" else coeff17; 
coeff21_nxt <= coeff_in(6 downto 0)     when counter_2 = "00011" else coeff21;
coeff25_nxt <= coeff_in(13 downto 7)    when counter_2 = "00100" else coeff25; 
coeff29_nxt <= coeff_in(6 downto 0)     when counter_2 = "00100" else coeff29;
coeff02_nxt <= coeff_in(13 downto 7)    when counter_2 = "00101" else coeff02; 
coeff06_nxt <= coeff_in(6 downto 0)     when counter_2 = "00101" else coeff06;
coeff10_nxt <= coeff_in(13 downto 7)    when counter_2 = "00110" else coeff10; 
coeff14_nxt <= coeff_in(6 downto 0)     when counter_2 = "00110" else coeff14;
coeff18_nxt <= coeff_in(13 downto 7)    when counter_2 = "00111" else coeff18; 
coeff22_nxt <= coeff_in(6 downto 0)     when counter_2 = "00111" else coeff22;
coeff26_nxt <= coeff_in(13 downto 7)    when counter_2 = "01000" else coeff26; 
coeff30_nxt <= coeff_in(6 downto 0)     when counter_2 = "01000" else coeff30;
coeff03_nxt <= coeff_in(13 downto 7)    when counter_2 = "01001" else coeff03; 
coeff07_nxt <= coeff_in(6 downto 0)     when counter_2 = "01001" else coeff07;
coeff11_nxt <= coeff_in(13 downto 7)    when counter_2 = "01010" else coeff11; 
coeff15_nxt <= coeff_in(6 downto 0)     when counter_2 = "01010" else coeff15;
coeff19_nxt <= coeff_in(13 downto 7)    when counter_2 = "01011" else coeff19; 
coeff23_nxt <= coeff_in(6 downto 0)     when counter_2 = "01011" else coeff23;
coeff27_nxt <= coeff_in(13 downto 7)    when counter_2 = "01100" else coeff27; 
coeff31_nxt <= coeff_in(6 downto 0)     when counter_2 = "01100" else coeff31;
coeff04_nxt <= coeff_in(13 downto 7)    when counter_2 = "01101" else coeff04; 
coeff08_nxt <= coeff_in(6 downto 0)     when counter_2 = "01101" else coeff08;
coeff12_nxt <= coeff_in(13 downto 7)    when counter_2 = "01110" else coeff12; 
coeff16_nxt <= coeff_in(6 downto 0)     when counter_2 = "01110" else coeff16;
coeff20_nxt <= coeff_in(13 downto 7)    when counter_2 = "01111" else coeff20; 
coeff24_nxt <= coeff_in(6 downto 0)     when counter_2 = "01111" else coeff24;
coeff28_nxt <= coeff_in(13 downto 7)    when counter_2 = "10000" else coeff28; 
coeff32_nxt <= coeff_in(6 downto 0)     when counter_2 = "10000" else coeff32;



counter_ff: FF
generic map(N => 5)
  port map(   D     =>counter_nxt,
              Q     =>counter,
            clk     =>clk,
            reset   =>reset
      );
counter_2_ff: FF 
  generic map(N => 5)
  port map(   D     =>counter_2_nxt,
              Q     =>counter_2,
            clk     =>clk,
            reset   =>reset
      );
coeff_01: FF 
  generic map(N => 7)
  port map(   D     =>coeff01_nxt,
              Q     =>coeff01,
            clk     =>clk,
            reset   =>reset
      );
coeff_02: FF 
  generic map(N => 7)
  port map(   D     =>coeff02_nxt,
              Q     =>coeff02,
            clk     =>clk,
            reset   =>reset
      );
coeff_03: FF 
  generic map(N => 7)
  port map(   D     =>coeff03_nxt,
              Q     =>coeff03,
            clk     =>clk,
            reset   =>reset
      );
coeff_04: FF 
  generic map(N => 7)
  port map(   D     =>coeff04_nxt,
              Q     =>coeff04,
            clk     =>clk,
            reset   =>reset
      );
coeff_05: FF 
  generic map(N => 7)
  port map(   D     =>coeff05_nxt,
              Q     =>coeff05,
            clk     =>clk,
            reset   =>reset
      );
coeff_06: FF 
  generic map(N => 7)
  port map(   D     =>coeff06_nxt,
              Q     =>coeff06,
            clk     =>clk,
            reset   =>reset
      );
coeff_07: FF 
  generic map(N => 7)
  port map(   D     =>coeff07_nxt,
              Q     =>coeff07,
            clk     =>clk,
            reset   =>reset
      );
coeff_08: FF 
  generic map(N => 7)
  port map(   D     =>coeff08_nxt,
              Q     =>coeff08,
            clk     =>clk,
            reset   =>reset
      );
coeff_09: FF 
  generic map(N => 7)
  port map(   D     =>coeff09_nxt,
              Q     =>coeff09,
            clk     =>clk,
            reset   =>reset
      );
coeff_10: FF 
  generic map(N => 7)
  port map(   D     =>coeff10_nxt,
              Q     =>coeff10,
            clk     =>clk,
            reset   =>reset
      );
coeff_11: FF 
  generic map(N => 7)
  port map(   D     =>coeff11_nxt,
              Q     =>coeff11,
            clk     =>clk,
            reset   =>reset
      );
coeff_12: FF 
  generic map(N => 7)
  port map(   D     =>coeff12_nxt,
              Q     =>coeff12,
            clk     =>clk,
            reset   =>reset
      );
coeff_13: FF 
  generic map(N => 7)
  port map(   D     =>coeff13_nxt,
              Q     =>coeff13,
            clk     =>clk,
            reset   =>reset
      );
coeff_14: FF 
  generic map(N => 7)
  port map(   D     =>coeff14_nxt,
              Q     =>coeff14,
            clk     =>clk,
            reset   =>reset
      );
coeff_15: FF 
  generic map(N => 7)
  port map(   D     =>coeff15_nxt,
              Q     =>coeff15,
            clk     =>clk,
            reset   =>reset
      );
coeff_16: FF 
  generic map(N => 7)
  port map(   D     =>coeff16_nxt,
              Q     =>coeff16,
            clk     =>clk,
            reset   =>reset
      );
coeff_17: FF 
  generic map(N => 7)
  port map(   D     =>coeff17_nxt,
              Q     =>coeff17,
            clk     =>clk,
            reset   =>reset
      );
coeff_18: FF 
  generic map(N => 7)
  port map(   D     =>coeff18_nxt,
              Q     =>coeff18,
            clk     =>clk,
            reset   =>reset
      );
coeff_19: FF 
  generic map(N => 7)
  port map(   D     =>coeff19_nxt,
              Q     =>coeff19,
            clk     =>clk,
            reset   =>reset
      );
coeff_20: FF 
  generic map(N => 7)
  port map(   D     =>coeff20_nxt,
              Q     =>coeff20,
            clk     =>clk,
            reset   =>reset
      );
coeff_21: FF 
  generic map(N => 7)
  port map(   D     =>coeff21_nxt,
              Q     =>coeff21,
            clk     =>clk,
            reset   =>reset
      );
coeff_22: FF 
  generic map(N => 7)
  port map(   D     =>coeff22_nxt,
              Q     =>coeff22,
            clk     =>clk,
            reset   =>reset
      );
coeff_23: FF 
  generic map(N => 7)
  port map(   D     =>coeff23_nxt,
              Q     =>coeff23,
            clk     =>clk,
            reset   =>reset
      );
coeff_24: FF 
  generic map(N => 7)
  port map(   D     =>coeff24_nxt,
              Q     =>coeff24,
            clk     =>clk,
            reset   =>reset
      );
coeff_25: FF 
  generic map(N => 7)
  port map(   D     =>coeff25_nxt,
              Q     =>coeff25,
            clk     =>clk,
            reset   =>reset
      );
coeff_26: FF 
  generic map(N => 7)
  port map(   D     =>coeff26_nxt,
              Q     =>coeff26,
            clk     =>clk,
            reset   =>reset
      );
coeff_27: FF 
  generic map(N => 7)
  port map(   D     =>coeff27_nxt,
              Q     =>coeff27,
            clk     =>clk,
            reset   =>reset
      );
coeff_28: FF 
  generic map(N => 7)
  port map(   D     =>coeff28_nxt,
              Q     =>coeff28,
            clk     =>clk,
            reset   =>reset
      );
coeff_29: FF 
  generic map(N => 7)
  port map(   D     =>coeff29_nxt,
              Q     =>coeff29,
            clk     =>clk,
            reset   =>reset
      );
coeff_30: FF 
  generic map(N => 7)
  port map(   D     =>coeff30_nxt,
              Q     =>coeff30,
            clk     =>clk,
            reset   =>reset
      );
coeff_31: FF 
  generic map(N => 7)
  port map(   D     =>coeff31_nxt,
              Q     =>coeff31,
            clk     =>clk,
            reset   =>reset
      );
coeff_32: FF 
  generic map(N => 7)
  port map(   D     =>coeff32_nxt,
              Q     =>coeff32,
            clk     =>clk,
            reset   =>reset
      );


end Behavioral;
