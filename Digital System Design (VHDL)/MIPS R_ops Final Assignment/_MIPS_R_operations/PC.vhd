library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity PC is port(
    CLK : in std_logic;
    Rst : in std_logic;
    inPC: in std_logic_vector(3 downto 0):="0000";
    outPC : out std_logic_vector(3 downto 0):="0000");
end PC;
architecture PC_1 of PC is
begin
    process (CLK) begin
        if Rst = '1' then
            outPC <= "0000";
        elsif (rising_edge(CLK)) then
            outPC <= inPC;
        end if;
    end process;
end PC_1;