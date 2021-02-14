--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity key_expansion is
    port(
	key_in	: in std_logic_vector(2*BLOCK_SIZE-1 downto 0); -- {round_key[i+3], round_key[i+2], round_key[i+1], round_key[i]}
	round_count : in std_logic_vector(4 downto 0); -- current round
	key_out	: out std_logic_vector(WORD_SIZE-1 downto 0) -- round_key[i+4]
    );

end key_expansion;

architecture BHV of key_expansion is
----------- your signals here -----------

begin

    process(key_in, round_count)
	  variable zvar : std_logic_vector(0 downto 0);  --Z Variable. Defined in constants.vhd
	  constant c : std_logic_vector(WORD_SIZE-1 downto 0) := X"0003"; -- Constant C
	  ----------- your variables here -----------
	  
    begin
       
    ----------- your code here -----------
	
    end process;

end BHV;
