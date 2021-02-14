--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity simon_top is
    port(
	clk		: in std_logic;
	rst		: in std_logic;	
	go			: in std_logic;
	valid 	: out std_logic; --denotes output is valid.
	done 		: out std_logic);

end simon_top;

architecture STR of simon_top is

signal simon_out 						: std_logic_vector(BLOCK_SIZE-1 downto 0); -- map to output of your simon cipher instance. DO NOT TOUCH
----------- your signals here -----------
signal inRam 							:std_logic_vector(2*BLOCK_SIZE-1 downto 0);
signal s1 			 					:std_logic_vector(BLOCK_SIZE-1 downto 0);
signal rCount,addrIn,addrOut 		:std_logic_vector(4 downto 0):="00000";
signal muxX_sel,muxY_sel 						:std_logic_vector(1 downto 0);
signal yEn,xEn,ramEn,vEn,keyEn	:std_logic;

begin 
sp_simon_out <= simon_out; --for testbench to work, this signal assignment is needed. DO NOT TOUCH

Controller_1: entity work.controller 
		port map(
		clk 			 => clk, 
		rst 			 => rst, 
		go				 => go, 
		round_count  => rCount,
		done	       => done, 
		mux_x_sel    => muxX_sel,
		mux_y_sel    => muxY_sel,
		ff_key_en    => keyEn,
		ff_x_en      => xEn,
		ff_y_en      => yEn,
		addr_in	    => addrIn,
		valid	       => vEn,
		out_ram_wren => ramEn);

Simon_1: entity work.simon 
		port map (
		clk 			 => clk,
		rst 			 => rst,
		key_in 		 => inRam,
		input			 => s1,
		round_count	 => rCount, 
		mux_x_sel 	 => muxX_sel,
		mux_y_sel 	 => muxY_sel,
		ff_key_en 	 => keyEn,
		ff_x_en 		 => xEn,
		ff_y_en 		 => yEn,
		output  		 => simon_out  --input for the outram
		);

Counter_1: entity work.counter5bit
		port map (
		clk 			 => clk,		
		rst 			 => rst,
		up 			 => vEn,		
		output 		 => addrIn
		);

Counter_2: entity work.counter5bit
		port map (
	   clk 			 => clk,
		rst 			 => rst, 
		up 			 => vEn,		
		output 		 => addrOut
		);


inram_1: entity work.inram 
		port map (
		address 		 => addrIn,
		clock 		 => clk,
		data 	 		 => (others => '0'),	
		wren 			 => '0',
		q   			 => s1
		);
outram_1: entity work.outram
		port map (
		address 		=> addrOut,
		clock 		=> clk, 
		data 			=> simon_out, 
		wren 			=> ramEn
		);

keyrom_1: entity work.keyrom 
		port map (
		address		=> "0",
		clock 		=> clk,
		q 			   => inRam
		);


valid <= vEn;
end STR;