LIBRARY ieee; USE ieee.std_logic_1164.all;
entity test_reg4 is end test_reg4;
ARCHITECTURE tb OF test_reg4 IS
    signal tRes, tClock: STD_LOGIC;
    signal tD, tQ: STD_LOGIC_VECTOR(3 DOWNTO 0);
    COMPONENT reg4 port (
        D:             IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Resetn, Clock: IN  STD_LOGIC;
        Q:             OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
BEGIN
    p1: reg4 PORT MAP(D=>tD, Resetn=>tRes, Clock=>tClock, Q=>tQ);
    PROCESS BEGIN
        tRes<='1'; tClock<='0';
        tD<="0010"; wait for 50 ps; tClock<='1'; wait for 50 ps; tClock<='0';
        tD<="1110"; wait for 50 ps; tClock<='1'; wait for 50 ps; tClock<='0';
        tD<="1010"; wait for 50 ps; tClock<='1'; wait for 50 ps; tClock<='0';
                    wait for 50 ps; tClock<='1'; wait for 50 ps; tClock<='0';  
    END PROCESS;
END tb;