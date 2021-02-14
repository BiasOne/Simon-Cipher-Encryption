library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity reg16 is
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
	 en	  : in  std_logic;
    input  : in  std_logic_vector(WORD_SIZE-1 downto 0);
    output : out std_logic_vector(WORD_SIZE-1 downto 0));
end reg16;

--architecture ASYNC_RST of reg2 is
--begin  -- ASYNC_RST

--  process(clk,rst)
 -- begin
    
    --if (rst = '1') then
   --   output <= (others => '0');      
   -- elsif (rising_edge(clk)) then
		--if(en ='1' ) then		
    --  output <= input;
	--	end if;
   -- end if;    
  --end process;

--end ASYNC_RST;


architecture SYNC_RST of reg16 is
begin  -- SYNC_RST

  process(clk,rst)
  begin

    if (rising_edge(clk)) then  
      if (rst = '1') then
        output <= (others => '0');
      elsif (en ='1' ) then	
        output <= input;              
      end if;     
    end if;    
  end process;
end SYNC_RST;

