LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity dec2to4 is port (
a: in std_logic_vector(1 downto 0);
d: out std_logic_vector(3 downto 0));
end dec2to4;

architecture dataflow of dec2to4 is
begin
    d<="0001" when a="00" else
       "0010" when a="01" else
       "0100" when a="10" else
       "1000" when a="11";
end dataflow;