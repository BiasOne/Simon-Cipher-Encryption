-- Greg Stitt
-- University of Florida

-- The following counter entity shows another basic sequential logic example,
-- but compares the usage of the integer type and unsigned type. For this
-- particular example, unsigned is arguably the better choice.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter5bit is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up     : in  std_logic;
        output : out std_logic_vector(4 downto 0));
end counter5bit;


architecture BHV_UNSIGNED of counter5bit is
    -- use a 4 bit unsigned instead of an integer.
    signal count : unsigned(4 downto 0);
    
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            count <= "00000";
        elsif (rising_edge(clk)) then

            -- notice here that we can just add or subtract 1            
            if (up = '1') then
                count <= count + 1;
            end if;
        end if;
    end process;

    output <= std_logic_vector(count);
       
end BHV_UNSIGNED;

