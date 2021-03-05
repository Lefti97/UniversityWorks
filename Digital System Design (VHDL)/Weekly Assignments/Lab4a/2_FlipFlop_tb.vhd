entity test_flipflop is
end test_flipflop;

ARCHITECTURE t_flipflop OF test_flipflop IS

signal Dte, CLKte, Qte: bit;

COMPONENT flipflop port (
    D : in bit;
    CLK : in bit;
    Q : out bit );
END COMPONENT;

BEGIN
    p1: flipflop PORT MAP(D=>Dte , CLK=>CLKte , Q=>Qte);
PROCESS
BEGIN
    -- t1
    CLKte<='1'; Dte<='1'; wait for 166 ns;
    CLKte<='0'; wait for 166 ns;
    Dte<='0'; wait for 267 ns; 
    --t2
    CLKte<='1'; wait for 266 ns;
    CLKte<='0'; wait for 166 ns;
    Dte<='1'; wait for 167 ns;
    --t3
    CLKte<='1'; wait for 140 ns;
    Dte<='0'; wait for 140 ns;
    CLKte<='0'; wait for 140 ns;
    Dte<='1'; wait for 90 ns;
    Dte<='0'; wait for 90 ns;
    --t4
    CLKte<='1'; wait for 50 ns;
    Dte<='1'; wait for 50 ns;
    CLKte<='0'; wait for 50 ns;
    Dte<='0';
END PROCESS;
END t_flipflop;