LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity test_shiftleft2 is
end test_shiftleft2;

architecture tb of test_shiftleft2 is
    component shiftleft2 is port(
        In1: in std_logic_vector(31 downto 0);
        d: out std_logic_vector(31 downto 0));
    end component;

    signal In1t: std_logic_vector(31 downto 0);
    signal dt  : std_logic_vector(31 downto 0);
begin
    pMap: shiftleft2 port map(In1 => In1t, d => dt);
    process begin
        In1t <= x"0000AAAF"; wait for 100 ps;
        In1t <= x"FFFFAAFF"; wait for 100 ps;
    end process;
end tb;