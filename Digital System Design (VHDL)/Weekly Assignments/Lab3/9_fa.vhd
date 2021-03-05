LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity fa is port (
A, B, Cin : in bit;
S, Cout : out bit);
end fa;

ARCHITECTURE dataflow OF fa IS
BEGIN
  S    <= (A XOR B) XOR Cin;
  Cout <=((A XOR B) AND Cin) OR (A AND B);
END dataflow;