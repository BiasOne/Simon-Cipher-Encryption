--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity simon is
    port(
	clk								 : in std_logic;
	rst								 : in std_logic;	
	key_in							 : in std_logic_vector(2*BLOCK_SIZE-1 downto 0); --key input
	input								 : in std_logic_vector(BLOCK_SIZE-1 downto 0); --plaintext or ciphertext
	round_count 					 : in std_logic_vector(4 downto 0); -- current round count
	mux_x_sel, mux_y_sel 		 : in std_logic_vector(1 downto 0); --control for muxes
	ff_key_en, ff_x_en, ff_y_en : in std_logic; --enable for FFs
	output							 : out std_logic_vector(BLOCK_SIZE-1 downto 0)); --final plaintext or ciphertext
end simon;

architecture datapath of simon is
----------- your signals here -----------
type KEY_EXPANSION_ARR is array (0 to N_ROUNDS-1) of std_logic_vector(WORD_SIZE-1 downto 0);
type ROUND_COUNT_ARR is array (0 to N_ROUNDS-1) of std_logic_vector(4 downto 0);
type r64_ARR is array (0 to N_ROUNDS-1) of std_logic_vector(2*BLOCK_SIZE-1 downto 0);

signal round_key 			 								: KEY_EXPANSION_ARR; --round keys
signal round_count_index 								: ROUND_COUNT_ARR; --index for round keys
signal r64													: r64_ARR;

signal muxX_out, muxY_out, regX_out, regY_out, round_key_temp	: std_logic_vector(word_size-1 downto 0);
signal round_out 											: std_logic_vector(block_size -1 downto 0);
signal regKey												: std_logic_vector(2*BLOCK_SIZE-1 downto 0)	:= (others => '0');

begin
-----initialize round keys taken from input here-------
round_key(0) <= regKey(15 downto 0);
round_key(1) <= regKey(31 downto 16);
round_key(2) <= regKey(47 downto 32);
round_key(3) <= regKey(63 downto 48);


--round count array for key expansion
round_count_index <= ("00000","00001","00010", "00011","00100","00101","00110","00111",
                "01000","01001","01010","01011");
				
-- generate round keys
GEN_ROUND_KEYS: for i in 4 to N_ROUNDS-1 generate

----------- your code here -----------
r64(i) <= round_key(i-1) & round_key(i-2) & round_key(i-3) & round_key(i-4); --

keyExp: entity work.key_expansion
			port map(
			key_in		=> r64(i), --round_key(i)
			round_count => round_count_index(i),
			key_out	 	=> round_key(i)			
			);
			
		
end generate GEN_ROUND_KEYS;


----------- your code here -----------
MUX_X:   entity work.mux_4x1
		   port map (
			input1		=> input(31 downto 16),
			input2		=> input(15 downto 0),
			input3		=> round_out(31 downto 16),
         input4	   => round_out(15 downto 0),
			sel			=> mux_x_sel,
			output	   => muxX_out			
			);
			
MUX_Y:   entity work.mux_4x1
		   port map (
			input1		=> input(31 downto 16),
			input2		=> input(15 downto 0),
			input3		=> round_out(31 downto 16),
         input4	   => round_out(15 downto 0),
			sel			=> mux_y_sel,
			output		=> muxY_out			
			);	
			
REG16_X:	entity work.reg16
			port map(
			clk      =>	clk,
			rst		=> rst,   
			en 		=> ff_x_en,
			input  	=> muxX_out,
			output	=> regX_out
			);
			
REG16_Y:	entity work.reg16
			port map(
			clk      =>	clk,
			rst		=> rst,   
			en 		=> ff_y_en,
			input  	=> muxY_out,
			output	=> regY_out
			
			);
			
REG64_Key:entity work.reg64
			port map(
			clk      =>	clk,
			rst		=> rst,
			en 		=> ff_key_en,
			input  	=> key_in,
			output	=> regKey
			);
		
round:	entity work.round
			port map(
			x			 => regX_out,
			y			 => regY_out,
			round_key => round_key_temp,
			round_out => round_out
			); 
			
cat: 		entity work.cat
			port map(	
			in1 		=> regX_out,
			in2 		=> regY_out,
			output 	=> output
			);	
			
round_key_temp  <=  round_key(to_integer(unsigned(round_count)));			
end datapath;