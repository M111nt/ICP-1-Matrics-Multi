
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    port(
         clki        : in std_logic;
         reseti      : in std_logic;
         start      : in std_logic;
         datainput  : in std_logic_vector(13 downto 0);
         dataOutput : out std_logic_vector(18 downto 0);
         ld2mem     : out std_logic;
         ld2reg     : out std_logic
--         input_write_en_o : out std_logic; 
--         rom_write_en_o   : out std_logic
        );
end Top;

architecture Behavioral of top is



--  component CPAD_S_74x50u_IN            --input PAD
--    port (
--      COREIO : out std_logic;
--      PADIO  : in  std_logic);
--  end component;

--  component CPAD_S_74x50u_OUT           --output PAD
--    port (
--      COREIO : in  std_logic;
--      PADIO  : out std_logic);
--  end component;

--    component SRAM_SP_WRAPPER
--      port (
--        ClkxCI  : in  std_logic;
--        CSxSI   : in  std_logic;            -- Active Low
--        WExSI   : in  std_logic;            --Active Low
--        AddrxDI : in  std_logic_vector (7 downto 0);
--        RYxSO   : out std_logic;
--        DataxDI : in  std_logic_vector (31 downto 0);
--        DataxDO : out std_logic_vector (31 downto 0)
--        );
--    end component;
--------------------------------------------------------------------------------------------------------------------
component controller is
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
        max_en          : out std_logic;
        avg_en          : out std_logic;   
    --ld coeff--------------------------------------------------------------       
    --ld input--------------------------------------------------------------
        column_out        : out std_logic_vector(1 downto 0);
    --number to op----------------------------------------------------------    
        data2op         : out std_logic_vector(7 downto 0);
        address2op      : out std_logic_vector(5 downto 0);
    ----------------------------------------------------------------
        result1_2store  : out std_logic_vector(18 downto 0);
        result2_2store  : out std_logic_vector(18 downto 0);
        result3_2store  : out std_logic_vector(18 downto 0);
        result4_2store  : out std_logic_vector(18 downto 0)  
    );

end component;
-------------------------------------------------------------------------------------------------------------
component load_coeff is
  Port (
     clk, reset     : in std_logic;
    ldcoeff_enable  : in std_logic;
    coeff_read      : in std_logic_vector(13 downto 0);
    ld2mem          : out std_logic;
    --address         : out std_logic_vector(3 downto 0);
    --to controller---------------------------------------------------------
    ctrl_coeff      : out std_logic_vector(5 downto 0);
    coeff           : out std_logic_vector(6 downto 0);
    ldcoeff_done    : out std_logic
  );
end component;
------------------------------------------------------------------------------------------------------------------------
component load_input is
  Port (
        clk             : in std_logic; 
        reset           : in std_logic; 
        ldinput_en      : in std_logic;
        column          : in std_logic_vector(1 downto 0);
        load_en         : in std_logic;
        input_in        : in std_logic_vector(7 downto 0);
        ld2reg          : out std_logic;        
        ctrl_input      : out std_logic_vector(3 downto 0);
        input           : out std_logic_vector(7 downto 0);
        ldinput_done    : out std_logic;
        load_done       : out std_logic
  );
end component;
------------------------------------------------------------------------------------------------------------------------
component operation is
  Port (
        clk, reset      : in std_logic;
        op_en           : in std_logic;
        data2op         : in std_logic_vector(7 downto 0);
        address2op      : in std_logic_vector(5 downto 0);
        op_done         : out std_logic;
        result1_out     : out std_logic_vector(18 downto 0);
        result2_out     : out std_logic_vector(18 downto 0);
        result3_out     : out std_logic_vector(18 downto 0);
        result4_out     : out std_logic_vector(18 downto 0);
        compare_out     : out std_logic_vector(18 downto 0)
        
  );
end component;
---------------------------------------------------------------------------------------------------------------------------------
component comparison is
  Port (
    clk, reset      : in std_logic;
    max_en          : in std_logic;
    --compare_done    : in std_logic; 
    compare_out     : in std_logic_vector(18 downto 0); 
    
    compare_result  : out std_logic_vector(18 downto 0)

  );
end component;
-----------------------------------------------------------------------------------------------------------------------------------
component store_result is
  Port (
        clk, reset      : in std_logic;
        store_en        : in std_logic;
        result1_2store  : in std_logic_vector(18 downto 0);
        result2_2store  : in std_logic_vector(18 downto 0);
        result3_2store  : in std_logic_vector(18 downto 0);
        result4_2store  : in std_logic_vector(18 downto 0);
        store_done      : out std_logic
  );
end component;


--signal---------------------------------------------------------------------------------------------------------------------
--signal clki, reseti    : std_logic;  
--signal load_en          : std_logic;
--signal coeff_in         : std_logic_vector(31 downto 0);
--signal ld2mem_o         : std_logic;
--signal address          : std_logic_vector(7 downto 0);
--signal ctrl_coeff       : std_logic_vector(5 downto 0);
--signal coeff            : std_logic_vector(6 downto 0);
--signal ldcoeff_done     : std_logic;

signal ldcoeff_done    : std_logic;
signal ldinput_done    : std_logic; 
signal start_i         : std_logic; 
signal load_done       : std_logic; 
signal op_done         : std_logic;
signal store_done      : std_logic;
signal ctrl_coeff      : std_logic_vector(5 downto 0);
signal coeff           : std_logic_vector(6 downto 0);
signal ctrl_input      : std_logic_vector(3 downto 0);
signal input           : std_logic_vector(7 downto 0);
signal result1         : std_logic_vector(18 downto 0);
signal result2         : std_logic_vector(18 downto 0);
signal result3         : std_logic_vector(18 downto 0);
signal result4         : std_logic_vector(18 downto 0);    
     
signal ldcoeff_enable  : std_logic;
signal ldinput_enable  : std_logic; 
signal load_en         : std_logic;
signal op_en           : std_logic;
signal store_en        : std_logic; 
signal max_en          : std_logic;
signal avg_en          : std_logic;   
signal column_out      : std_logic_vector(1 downto 0); 
signal data2op         : std_logic_vector(7 downto 0);
signal address2op      : std_logic_vector(5 downto 0);
signal result1_2store  : std_logic_vector(18 downto 0);
signal result2_2store  : std_logic_vector(18 downto 0);
signal result3_2store  : std_logic_vector(18 downto 0);
signal result4_2store  : std_logic_vector(18 downto 0);

signal compare_out     : std_logic_vector(18 downto 0);    
signal compare_result  : std_logic_vector(18 downto 0);
  
signal CSN_rom         : std_logic;            -- Active Low
signal We              : std_logic;            --Active Low 
signal addrxdi         : std_logic_vector (7 downto 0);     
signal RY_rom          : std_logic;                         
signal data_in         : std_logic_vector (31 downto 0);    
signal data_rom        : std_logic_vector (31 downto 0);     

--signal coeff_read      : std_logic_vector(13 downto 0);

begin
--Rom:SRAM_SP_WRAPPER
--port map(
--    ClkxCI              => clki          ,
--    CSxSI               => CSN_rom       , -- Active Low
--    WExSI               => We            , -- Active Low
--    AddrxDI             => addrxdi       ,
--    RYxSO               => RY_rom        ,
--    DataxDI             => data_in       ,
--    DataxDO             => data_rom
--    );

controller_part: controller 
port map(
        clk             => clki             ,
        reset           =>reseti            ,
        ldcoeff_done    => ldcoeff_done     ,
        ldinput_done    => ldinput_done     ,
        start           => start            ,
        load_done       => load_done        ,
        op_done         => op_done          ,
        store_done      => store_done       ,
        ctrl_coeff      => ctrl_coeff       ,
        coeff           => coeff            ,
        ctrl_input      => ctrl_input       ,
        input           => input            ,
        result1         => result1          ,
        result2         => result2          ,
        result3         => result3          ,
        result4         => result4          ,      
        ldcoeff_enable  => ldcoeff_enable   ,
        ldinput_enable  => ldinput_enable   ,
        load_en         => load_en          ,
        op_en           => op_en            ,
        store_en        => store_en         ,
        max_en          => max_en           ,
        avg_en          => avg_en           ,
        column_out      => column_out       ,
        data2op         => data2op          ,
        address2op      => address2op       ,
        result1_2store  => result1_2store   ,
        result2_2store  => result2_2store   ,
        result3_2store  => result3_2store   ,
        result4_2store  => result4_2store

);

coeff_part: load_coeff
port map(
        clk             => clki             ,
        reset           => reseti           ,
        ldcoeff_enable  => ldcoeff_enable   ,
        coeff_read      => datainput        ,
        ld2mem          => ld2mem           ,
        ctrl_coeff      => ctrl_coeff       ,
        coeff           => coeff            ,
        ldcoeff_done    => ldcoeff_done     

);

input_part: load_input
port map(

        clk            => clki              ,
        reset          => reseti            ,
        ldinput_en     => ldinput_enable    ,
        column         => column_out        ,    
        load_en        => load_en           ,
        input_in       => datainput(7 downto 0),
        ld2reg         => ld2reg            ,
        ctrl_input     => ctrl_input        ,
        input          => input             ,
        ldinput_done   => ldinput_done      ,
        load_done      => load_done         
  );


operation_part: operation
port map(
        clk             => clki             ,
        reset           => reseti           ,
        op_en           => op_en            ,
        data2op         => data2op          ,
        address2op      => address2op       ,
        op_done         => op_done          ,
        result1_out     => result1          ,
        result2_out     => result2          ,
        result3_out     => result3          ,
        result4_out     => result4          ,
        compare_out     => compare_out      
);

store_part: store_result
port map(
        clk             => clki             ,
        reset           => reseti           ,
        store_en        => store_en         ,
        result1_2store  => result1_2store   ,
        result2_2store  => result2_2store   ,
        result3_2store  => result3_2store   ,
        result4_2store  => result4_2store   ,
        store_done      => store_done       
);


comparison_part: comparison
port map(
        clk             => clki             ,
        reset           => reseti           ,
        max_en          => max_en           ,
        compare_out     => compare_out      ,
        compare_result  => compare_result   
);

end Behavioral;
