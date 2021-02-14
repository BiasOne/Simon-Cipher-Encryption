library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;


entity cat is
  port (
    in1    : in  std_logic_vector(word_Size-1 downto 0);
	 in2    : in  std_logic_vector(word_Size-1 downto 0);
    output : out std_logic_vector(block_size-1 downto 0));
end cat;

architecture BHVcat of cat is

begin 
  output <= in1 & in2;
end BHVcat;