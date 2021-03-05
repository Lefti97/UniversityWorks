LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity test_reg8 is
end test_reg8;

ARCHITECTURE tb OF test_reg8 IS

signal tD: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal tRes, tClock: STD_LOGIC;
signal tQ: STD_LOGIC_VECTOR(3 DOWNTO 0);

COMPONENT reg8 port (
    D:             IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    Resetn, Clock: IN  STD_LOGIC;
    Q:             OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;

BEGIN
    p1: reg8 PORT MAP(D=>tD, Resetn=>tRes, Clock=>tClock, Q=>tQ);
PROCESS
BEGIN
    tD<="0010";
    tRes<='1';
    tClock<='0';
    wait for 50 ps; tClock<='1';
    wait for 50 ps; tClock<='0';
    tD<="1110";
    wait for 50 ps; tClock<='1';
    wait for 50 ps; tClock<='0';
    tD<="1010";
    wait for 50 ps; tClock<='1';
    wait for 50 ps; tClock<='0';
    tRes<='0';
    wait for 50 ps; tClock<='1';
    wait for 50 ps; tClock<='0';
END PROCESS;
END tb;