library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.textio.all;


entity read_input is
  generic (
        FILE_NAME: string ;
        INPUT_WIDTH: positive
        ); 
    Port (
        clk:            in std_logic;
        reset:          in std_logic;
        ld2reg:         in std_logic;
        input_sample:   out std_logic_vector(INPUT_WIDTH-1 downto 0)
        );

end read_input;

architecture Behavioral of read_input is

begin

process (clk, reset)

      file test_vector_file: text open READ_MODE is FILE_NAME;
      variable file_row: line;
      variable input_raw: bit_vector(INPUT_WIDTH-1 downto 0);

begin
      if (reset = '1') then
          input_sample <= (others => '0');  
      elsif rising_edge(clk) then
          if not endfile(test_vector_file) and ld2reg='1' then
              readline(test_vector_file, file_row);
              read(file_row, input_raw);                
          end if;
          input_sample <=to_stdlogicvector(input_raw);
      end if;
end process;


end Behavioral;