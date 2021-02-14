--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity controller is
    port(
	clk	: in std_logic;
	rst	: in std_logic;
	go	: in std_logic;
	round_count : out std_logic_vector(4 downto 0); --round count signal
	done	: out std_logic;
	mux_x_sel : out std_logic_vector(1 downto 0);
	mux_y_sel : out std_logic_vector(1 downto 0);
	ff_key_en : out std_logic;
	ff_x_en   : out std_logic;
	ff_y_en   : out std_logic;
	addr_in	: in std_logic_vector(4 downto 0); --address from input or output RAM
	valid	  : out std_logic;  -- data valid signal
	out_ram_wren : out std_logic	); --output RAM write enable

end controller;

architecture FSM2P of controller is
----------- your signals here -----------

begin
----------- your code for 2 Process FSM -----------


end FSM2P;