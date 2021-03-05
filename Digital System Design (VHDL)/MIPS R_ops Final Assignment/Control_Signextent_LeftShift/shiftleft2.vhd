LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity shiftleft2 is port (
    In1: in std_logic_vector(31 downto 0);
    d: out std_logic_vector(31 downto 0));
end shiftleft2;

architecture sll2 of shiftleft2 is
begin
    d <= In1(29 downto 0) & "00";
end sll2;