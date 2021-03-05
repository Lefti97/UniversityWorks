library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity dataMemory is port (
    clk  : in std_logic;
    Addr : in std_logic_vector(5 downto 0);
    writeD : in std_logic_vector(31 downto 0);
    we : in std_logic;
    re : in std_logic;
    readD : out std_logic_vector(31 downto 0));
end dataMemory;

architecture behavioral of datamemory is
    type memArray is array(0 to 63) of std_logic_vector(31 downto 0);
    signal memfile : memArray;
begin
    process(clk) begin
        if (clk 'event and clk='0') then
            if we='1' then
                memfile(to_integer(unsigned(Addr))) <= writeD;
            end if;
        end if;
        if re='1' then
            readD <= memfile(to_integer(unsigned(Addr)));
        end if;
    end process;
end behavioral;