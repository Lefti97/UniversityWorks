library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity adder is port(
    inp : in std_logic_vector(3 downto 0) := "0000";
    outp: out std_logic_vector(3 downto 0):= "0000");
end adder;
architecture adder_1 of adder is
    signal x : std_logic_vector(3 downto 0) := "0001";
begin
    outp <= std_logic_vector(unsigned(inp) + unsigned(x));
end adder_1;