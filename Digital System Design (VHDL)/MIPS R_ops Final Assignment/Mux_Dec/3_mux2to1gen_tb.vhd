LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity t_mux2to1gen is
end t_mux2to1gen;

architecture tb of t_mux2to1gen is
    constant dw1 : natural := 4;
    signal A1,B1,C1: std_logic_vector(dw1-1 downto 0);
    signal s1: std_logic;
    component mux2to1gen
        generic (
        dw : natural := 4);
        port (
        A : in std_logic_vector(dw-1 downto 0);
        B : in std_logic_vector(dw-1 downto 0);
        s : in std_logic;
        C : out std_logic_vector(dw-1 downto 0));
    end component;
begin
    portMap: mux2to1gen 
        generic map(dw=>dw1)
        port map(A=>A1, B=>B1, s=>s1, C=>C1);
    process begin
        A1<="0000"; B1<="1101"; s1<='0'; wait for 50 ps;
        A1<="0000"; B1<="1101"; s1<='1'; wait for 50 ps;
    end process;
end tb;