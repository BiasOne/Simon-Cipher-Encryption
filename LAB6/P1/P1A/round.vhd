--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity round is
    port(
        x	: in std_logic_vector(WORD_SIZE-1 downto 0); --most significant word of input
        y	: in std_logic_vector(WORD_SIZE-1 downto 0); -- least signficant word of input
	round_key : in std_logic_vector(WORD_SIZE-1 downto 0); 
	round_out : out std_logic_vector(BLOCK_SIZE-1 downto 0)
    );

end round;

architecture BHV of round is



begin

    process(x,y,round_key)	
	 
	 variable rL1, rl2, rL8: std_logic_vector(word_size-1 downto 0);
	 variable	tmp: std_logic_vector(block_size-1 downto 0);
	
    begin
	 tmp(block_size-1 downto word_size) := x;
	 tmp(word_size-1 downto 0) := y;
 
	 rL1 := std_logic_vector(rotate_left(unsigned(tmp(block_size-1 downto word_size)), 1));
	 rL8 := std_logic_vector(rotate_left(unsigned(tmp(block_size-1 downto word_size)), 8));
	 rL2 := std_logic_vector(rotate_left(unsigned(tmp(block_size-1 downto word_size)), 2));
	 tmp := ((rL1 and rL8) xor rL2 xor tmp(word_size-1 downto 0) xor round_key) & tmp(block_size-1 downto word_size);
	
	 round_out <= tmp;
    end process;

	
end BHV;
