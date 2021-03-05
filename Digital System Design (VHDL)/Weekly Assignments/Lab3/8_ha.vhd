LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity ha is port (
A, B : in bit;
S,C : out bit);
end ha;

ARCHITECTURE dataflow OF ha IS
BEGIN
  S <= A XOR B;
  C <= A AND B;
END dataflow;