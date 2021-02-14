--Jonathan Cruz
--University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity controller is
    port(
	 
	clk				: in std_logic;
	rst				: in std_logic;
	go					: in std_logic;
	round_count 	: out std_logic_vector(4 downto 0); --round count signal
	done				: out std_logic;
	mux_x_sel 		: out std_logic_vector(1 downto 0);
	mux_y_sel 		: out std_logic_vector(1 downto 0);
	ff_key_en 		: out std_logic;
	ff_x_en   		: out std_logic;
	ff_y_en   		: out std_logic;
	addr_in			: in std_logic_vector(4 downto 0); --address from input or output RAM
	valid	  			: out std_logic;  -- data valid signal
	out_ram_wren 	: out std_logic	
	); --output RAM write enable

end controller;

architecture FSM2P of controller is
----------- your signals here -----------
    type STATE_TYPE is (START, LOAD_KEY, LOAD,  LOOP_COND, LOOP_BODY, RAM_WRITE, STALL, FINISH);
    signal state, next_state : STATE_TYPE;

    signal count1, count2 : unsigned(4 downto 0) := "00000";
begin
----------- your code for 2 Process FSM -----------
process(clk, rst)
	begin
		if (rst = '1') then
			state 	<= START;
			count1 	<= "00000";		
		elsif(rising_edge(clk)) then
			state 	<= next_state;
			count1 	<= count2;
		end if;
	end process;
	
	
	process(state, go, addr_in, count1)
	begin	
		done			 <= '0';						
		mux_x_sel 	 <= "00";
		mux_y_sel 	 <= "00";
		done			 <= '0';
		ff_key_en 	 <= '0';
		ff_x_en   	 <= '0';
		ff_y_en   	 <= '0';
		valid	    	 <= '0';
		out_ram_wren <= '0';
		
		next_state <= state;
		count2 <= count1;
		
	case state is
----------------------------------------------------------		
	when START =>
	if(go ='1') then
	next_state <= LOAD_KEY;
	else 
	next_state <= START;
	end if;
----------------------------------------------------------	
	when LOAD_KEY =>
	ff_key_en	<= '1';
	count2		<= "00000";	
	next_state	<= LOAD;
----------------------------------------------------------			
	when LOAD =>
	ff_key_en	<= '0';
	mux_x_sel 	<= "00";
	mux_y_sel 	<= "01";	
	ff_x_en   	<= '1';
	ff_y_en   	<= '1';	
	next_state 	<= LOOP_COND;	
----------------------------------------------------------		
	when LOOP_COND =>	
	ff_key_en   <= '0';				
	iF(count1 	< "01011") then
	next_state 	<= LOOP_BODY;
	else
	ff_key_en   <= '0';	
	mux_x_sel 	<= "10";
	mux_y_sel 	<= "11";	
	ff_x_en   	<= '1';
	ff_y_en   	<= '1';
	next_state 	<= RAM_WRITE;
	end if;
	----------------------------------------------------------	
	when LOOP_BODY =>
	ff_key_en   <= '0';	
	mux_x_sel 	<= "10";
	mux_y_sel 	<= "11";	
	ff_x_en   	<= '1';
	ff_y_en   	<= '1';	
	count2 	   <= count1 + 1; 
	next_state  <= LOOP_COND;
	----------------------------------------------------------	
	when RAM_WRITE =>
	ff_key_en    <= '0';		
	out_ram_wren <='1';
	if(addr_in = "11111") then
	next_state 	 <= FINISH;	
	else	
	next_state   <=STALL;
	end if;
	----------------------------------------------------------		
	when STALL =>
	ff_key_en    <= '0';	
	valid        <= '1';		
	next_state   <= LOAD_KEY;	
	----------------------------------------------------------			
	WHEN FINISH =>
	ff_key_en    <= '0';
	done         <= '1';	
	
	when others => null;	
	end case;
	
end process; 
round_count <= std_logic_vector(count1);
end FSM2P;