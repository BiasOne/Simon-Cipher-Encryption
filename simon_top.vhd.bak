--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity simon_top is
    port(
	clk	: in std_logic;
	rst	: in std_logic;	
	go	: in std_logic;
	valid : out std_logic; --denotes output is valid.
	done : out std_logic);

end simon_top;

architecture STR of simon_top is

signal simon_out : std_logic_vector(BLOCK_SIZE-1 downto 0); -- map to output of your simon cipher instance. DO NOT TOUCH
----------- your signals here -----------


begin
----------- your code here -----------
sp_simon_out <= simon_out; --for testbench to work, this signal assignment is needed. DO NOT TOUCH




end STR;