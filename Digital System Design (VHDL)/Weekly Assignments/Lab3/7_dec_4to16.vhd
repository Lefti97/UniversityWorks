LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity dec_4to16 is port (
a: in std_logic_vector( 4 downto 1);
d: out std_logic_vector(16 downto 1));
end dec_4to16;

ARCHITECTURE dataflow OF dec_4to16 IS
BEGIN
  d(1)  <= NOT a(4) AND NOT a(3) AND NOT a(2) AND NOT a(1);
  d(2)  <= NOT a(4) AND NOT a(3) AND NOT a(2) AND     a(1);
  d(3)  <= NOT a(4) AND NOT a(3) AND     a(2) AND NOT a(1);
  d(4)  <= NOT a(4) AND NOT a(3) AND     a(2) AND     a(1);
  d(5)  <= NOT a(4) AND     a(3) AND NOT a(2) AND NOT a(1);
  d(6)  <= NOT a(4) AND     a(3) AND NOT a(2) AND     a(1);
  d(7)  <= NOT a(4) AND     a(3) AND     a(2) AND NOT a(1);
  d(8)  <= NOT a(4) AND     a(3) AND     a(2) AND     a(1);
  d(9)  <=     a(4) AND NOT a(3) AND NOT a(2) AND NOT a(1);
  d(10) <=     a(4) AND NOT a(3) AND NOT a(2) AND     a(1);
  d(11) <=     a(4) AND NOT a(3) AND     a(2) AND NOT a(1);
  d(12) <=     a(4) AND NOT a(3) AND     a(2) AND     a(1);
  d(13) <=     a(4) AND     a(3) AND NOT a(2) AND NOT a(1);
  d(14) <=     a(4) AND     a(3) AND NOT a(2) AND     a(1);
  d(15) <=     a(4) AND     a(3) AND     a(2) AND NOT a(1);
  d(16) <=     a(4) AND     a(3) AND     a(2) AND     a(1);
END dataflow;