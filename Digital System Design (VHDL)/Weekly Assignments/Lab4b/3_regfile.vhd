library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity regfile is
    generic ( 
        dw   : natural := 4;
        size : natural := 4;
        adrw : natural := 2);
    port ( 
        A    : in  std_logic_vector(dw-1 downto 0);
        Addr : in  std_logic_vector(adrw-1 downto 0);
        we   : in  std_logic;
        clk  : in  std_logic;
        C    : out std_logic_vector(dw-1 downto 0));
end regfile;

architecture behavioral of regfile is

type regArray is array(0 to size-1) of std_logic_vector(dw-1 downto 0);
signal regfile : regArray;

begin
    process(clk)
    begin
        if (clk'event and clk='0') then
            if we='1' then
                regfile(to_integer(unsigned(Addr))) <= A;
            end if;
        end if;
        C <= regfile(to_integer(unsigned(Addr)));
    end process;
end behavioral;