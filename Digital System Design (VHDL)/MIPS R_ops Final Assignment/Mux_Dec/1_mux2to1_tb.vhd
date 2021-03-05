LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity t_mux2to1 is
end t_mux2to1;

architecture tb of t_mux2to1 is
    signal a1,b1,s1,d1: std_logic;
    component mux2to1 port(
        a: in std_logic;
        b: in std_logic;
        s: in std_logic;
        d: out std_logic);
    end component;
begin
    portMap: mux2to1 port map (a=>a1, b=>b1, s=>s1, d=>d1);

    process begin
        a1<='1'; b1<='0'; s1<='1'; wait for 50 ps;
        a1<='1'; b1<='0'; s1<='0'; wait for 50 ps;
    end process;
end tb;