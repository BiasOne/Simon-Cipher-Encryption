
-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity mux_2x1 is
  port(
    in1    : in  std_logic_vector(WORD_SIZE-1 downto 0);
    in2    : in  std_logic_vector(WORD_SIZE-1 downto 0);
    sel    : in  std_logic;
    output : out std_logic_vector(WORD_SIZE-1 downto 0)
	 );
end mux_2x1;

architecture IF_STATEMENT of mux_2x1 is
begin



  process(in1, in2, sel)
  begin
  
    if (sel = '0') then
      output <= in1;
    else
      output <= in2;
    end if;
  end process;
end IF_STATEMENT;




