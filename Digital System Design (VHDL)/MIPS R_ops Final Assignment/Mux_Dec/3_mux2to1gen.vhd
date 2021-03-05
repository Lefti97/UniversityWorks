LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity mux2to1gen is
    generic (
    dw : natural := 4);
    port (
    A : in std_logic_vector(dw-1 downto 0);
    B : in std_logic_vector(dw-1 downto 0);
    s : in std_logic;
    C : out std_logic_vector(dw-1 downto 0));
end mux2to1gen;

architecture dataflow of mux2to1gen is
begin
    C <= A when s='1' else B;
end dataflow;