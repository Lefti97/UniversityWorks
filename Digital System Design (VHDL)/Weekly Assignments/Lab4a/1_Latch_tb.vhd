entity test_latch is
end test_latch;

ARCHITECTURE test_l OF test_latch IS

signal d1, en1, q1: bit;

COMPONENT latch port (
  D : in bit;
  EN : in bit;
  Q : out bit );
END COMPONENT;

BEGIN
  p1: latch PORT MAP(D=>d1 , EN=>en1 , Q=>q1);
PROCESS
BEGIN
  -- t1
  en1<='1'; d1<='1'; wait for 100 ns;
  en1<='0'; wait for 100 ns;
  d1<='0'; wait for 200 ns; 
  --t2
  en1<='1'; wait for 200 ns;
  en1<='0'; wait for 100 ns;
  d1<='1'; wait for 100 ns;
  --t3
  en1<='1'; wait for 100 ns;
  d1<='0'; wait for 100 ns;
  en1<='0'; wait for 100 ns;
  d1<='1'; wait for 50 ns;
  d1<='0'; wait for 50 ns;
  --t4
  en1<='1'; wait for 50 ns;
  d1<='1'; wait for 50 ns;
  en1<='0'; wait for 50 ns;
  d1<='0';
END PROCESS;
END test_l;



