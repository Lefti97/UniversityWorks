library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
entity regfile is port (
    Datain : in std_logic_vector(3 downto 0);
    Addr : in std_logic_vector(2 downto 0);
    we : in std_logic;
    clk : in std_logic;
    Dataout : out std_logic_vector(3 downto 0));
end regfile;
architecture behavioral of regfile is
    type regArray is array(0 to 7) of std_logic_vector(3 downto 0);
    signal regfile: regArray;
begin
    process(clk) begin
        if (clk'event and clk='0') then
            if we='1' then
                regfile(to_integer(unsigned(Addr))) <= Datain;
            end if;
        end if;
        Dataout <= regfile(to_integer(unsigned(Addr)));
    end process;
end behavioral;