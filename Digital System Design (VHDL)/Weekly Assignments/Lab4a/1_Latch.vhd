entity latch is port (
  D : in bit;
  EN : in bit;
  Q : out bit);
end latch;

ARCHITECTURE behavioral OF latch IS
BEGIN
  PROCESS (D,EN)
  BEGIN
      IF EN = '1' THEN
        Q <= D;
      END IF;
  END PROCESS;
END behavioral;