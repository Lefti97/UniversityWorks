LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity dec2to4 is
port (
a: in std_logic_vector(2 downto 1);
d: out std_logic_vector(4 downto 1));
end dec2to4;

ARCHITECTURE dataflow OF dec2to4 IS
BEGIN
  d(1) <= NOT a(2) AND NOT a(1);
  d(2) <= NOT a(2) AND     a(1);
  d(3) <=     a(2) AND NOT a(1);
  d(4) <=     a(2) AND     a(1);
END dataflow;