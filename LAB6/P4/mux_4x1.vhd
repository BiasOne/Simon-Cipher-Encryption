library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity mux_4x1 is
	port(
		input1, input2, input3, input4 : in std_logic_vector(word_size-1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		output : out std_logic_vector(WORD_SIZE-1 downto 0)
	);
end mux_4x1;

architecture STR of mux_4x1 is

	signal mux1_out, mux2_out : std_logic_vector(WORD_SIZE-1 downto 0);

begin
	U_MUX1 : entity work.mux_2x1 port map (
		in1 => input1,
		in2 => input2,
		sel => sel(0),
		output => mux1_out
	);
	
	U_MUX2 : entity work.mux_2x1 port map (
		in1 => input3,
		in2 => input4,
		sel => sel(0),
		output => mux2_out
	);
	
	U_MUX3 : entity work.mux_2x1 port map (
		in1 => mux1_out,
		in2 => mux2_out,
		sel => sel(1),
		output => output
	);
	
end STR;

