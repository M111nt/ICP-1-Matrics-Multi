
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;


entity store_result is
  Port (
        clk, reset      : in std_logic;
        
        store_en        : in std_logic;
        result1_2store  : in std_logic_vector(18 downto 0);
        result2_2store  : in std_logic_vector(18 downto 0);
        result3_2store  : in std_logic_vector(18 downto 0);
        result4_2store  : in std_logic_vector(18 downto 0);

        store_done      : out std_logic
--        address_out     : out std_logic_vector(7 downto 0);
--        result_out      : out std_logic_vector(31 downto 0)
  );
end store_result;

architecture Behavioral of store_result is

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


    type state_type is (s_initial, s_recieve, s_send1, s_send2, s_send3, s_send4);
    signal state_reg, state_nxt : state_type;
    
    signal address      : std_logic_vector (7 downto 0);-- := (others => '0');
    signal address_nxt  : std_logic_vector (7 downto 0) := (others => '0');
    
    signal result1  : std_logic_vector (18 downto 0);
    signal result2  : std_logic_vector (18 downto 0);
    signal result3  : std_logic_vector (18 downto 0);
    signal result4  : std_logic_vector (18 downto 0);
    
    
    signal address_out  : std_logic_vector(7 downto 0);
    signal result_out   : std_logic_vector(31 downto 0);

    signal RY_ram       : std_logic;
    signal data_out     : std_logic_vector(31 downto 0);

begin

Ram_store: SRAM_SP_WRAPPER
port map(
    ClkxCI             => clk           ,
    CSxSI              => '0'           , -- Active Low --only write in this module
    WExSI              => '0'           , -- Active Low
    AddrxDI            => address_out   ,
    RYxSO              => RY_ram        ,
    DataxDI            => result_out    ,
    DataxDO            => data_out 
    );



process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_initial; 
        address <= (others => '0');
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
        address <= address_nxt;
    end if;         
end process;


process(state_reg, store_en, address)
begin 
    case state_reg is 
        when s_initial => 
            store_done <= '0';
            result_out <= (others => '0');
            if store_en = '1' then 
                state_nxt <= s_recieve; 
            else 
                state_nxt <= s_initial;
            end if;
        
        
        when s_recieve => 
            store_done <= '0';
            address_nxt <= address + 1;
--            result1 <= result1_2store; 
--            result2 <= result2_2store;
--            result3 <= result3_2store;
--            result4 <= result4_2store;
            state_nxt <= s_send1;
        
        when s_send1 => 
            store_done <= '0';
            address_out <= address;
            address_nxt <= address + 1;
            result_out <= "0000000000000" & result1;
            state_nxt <= s_send2;

        when s_send2 => 
            store_done <= '0';
            address_out <= address;
            address_nxt <= address + 1;
            result_out <= "0000000000000" & result2;
            state_nxt <= s_send3;
        
        when s_send3 => 
            store_done <= '0';
            address_out <= address;
            address_nxt <= address + 1;
            result_out <= "0000000000000" & result3;
            state_nxt <= s_send4;
        
        when s_send4 => 
            store_done <= '1';
            address_out <= address;
            result_out <= "0000000000000" & result4;
            state_nxt <= s_initial;
        
        

    end case;

end process;

result1 <= result1_2store; 
result2 <= result2_2store;
result3 <= result3_2store;
result4 <= result4_2store;



end Behavioral;
