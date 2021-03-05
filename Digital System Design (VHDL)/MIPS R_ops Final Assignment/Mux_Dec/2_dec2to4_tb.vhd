LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity t_dec2to4 is
end t_dec2to4;

architecture tb of t_dec2to4 is
    signal a1: std_logic_vector(1 downto 0);
    signal d1: std_logic_vector(3 downto 0);
    component dec2to4 port(
        a: in std_logic_vector(1 downto 0);
        d: out std_logic_vector(3 downto 0));
    end component;
begin
    portMap: dec2to4 port map(a=>a1, d=>d1);

    process begin
        a1<="00"; wait for 50 ps;
        a1<="01"; wait for 50 ps;
        a1<="10"; wait for 50 ps;
        a1<="11"; wait for 50 ps;
    end process;
end tb;