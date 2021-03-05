LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity dec_2to4 is
port (
a: in std_logic_vector(2 downto 1);
en: in std_logic;
d: out std_logic_vector(4 downto 1) );
end dec_2to4;

ARCHITECTURE dataflow OF dec_2to4 IS
BEGIN
  d(1) <= en AND NOT a(2) AND NOT a(1);
  d(2) <= en AND NOT a(2) AND     a(1);
  d(3) <= en AND     a(2) AND NOT a(1);
  d(4) <= en AND     a(2) AND     a(1);
END dataflow;