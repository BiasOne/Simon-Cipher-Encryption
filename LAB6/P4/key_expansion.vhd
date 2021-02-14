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
	   variable kE1, kE2, kE3: std_logic_vector(word_size-1 downto 0);
	   variable	tmp: std_logic_vector(WORD_SIZE-1 downto 0);
		variable zeros: std_logic_vector(WORD_SIZE-1 downto 1);
	  
    begin
		zeros := (others => '0');
		zvar(0) := Z(to_integer(unsigned(round_count)-M) mod 62);
		kE1 := key_in(63 downto 48);
		kE2 := key_in(31 downto 16);
		kE3 := key_in(15 downto 0);
		
      tmp := std_logic_vector(rotate_right(unsigned(kE1), 3));
		tmp := std_logic_vector(unsigned(tmp) xor unsigned(kE2));
		tmp := std_logic_vector(unsigned(tmp) xor rotate_right(unsigned(tmp), 1));
		tmp := std_logic_vector((not unsigned(kE3)) xor unsigned(tmp) xor unsigned(Zeros)&unsigned(zvar) xor unsigned(c));
		key_out <=tmp;
		 
    ----------- your code here -----------
	
    end process;

end BHV;

 
