LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux2to1 is port (
a: in std_logic;
b: in std_logic;
s: in std_logic;
d: out std_logic);
end mux2to1;

architecture dataflow of mux2to1 is
begin
    d <= a when s='1' else b;
end dataflow;