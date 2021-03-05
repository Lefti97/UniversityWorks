LIBRARY ieee ;
USE ieee.std_logic_1164.all;

ENTITY adder4 IS PORT (
Cin  : IN  STD_LOGIC;
X, Y : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
Cout : OUT STD_LOGIC);
END adder4;

ARCHITECTURE dataflow OF adder4 IS
  signal C0,C1,C2: STD_LOGIC;
BEGIN
  S(0) <= (X(0) XOR Y(0)) XOR Cin;
    C0 <=((X(0) XOR Y(0)) AND Cin) OR (X(0) AND Y(0));
  S(1) <= (X(1) XOR Y(1)) XOR C0;
    C1 <=((X(1) XOR Y(1)) AND C0) OR (X(1) AND Y(1));
  S(2) <= (X(2) XOR Y(2)) XOR C1;
    C2 <=((X(2) XOR Y(2)) AND C1) OR (X(2) AND Y(2));
  S(3) <= (X(3) XOR Y(3)) XOR C2;
  Cout <=((X(3) XOR Y(3)) AND C2) OR (X(3) AND Y(3));
END dataflow;