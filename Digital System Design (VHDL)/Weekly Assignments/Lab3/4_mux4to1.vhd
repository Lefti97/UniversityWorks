LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_4to1 IS PORT (
a: IN std_logic_vector(4 DOWNTO 1);
s: IN std_logic_vector(2 DOWNTO 1);
d: OUT std_logic);
END mux_4to1;

ARCHITECTURE dataflow OF mux_4to1 IS 
  signal e0 : std_logic;
  signal e1 : std_logic;
BEGIN
  e0 <= a(1) WHEN s(1)='0' ELSE a(2);
  e1 <= a(3) WHEN s(1)='0' ELSE a(4);
  d  <= e0   WHEN s(2)='0' ELSE e1;
END dataflow;