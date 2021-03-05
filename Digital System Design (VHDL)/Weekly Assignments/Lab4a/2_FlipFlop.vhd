entity flipflop is port (
D : in bit;
CLK : in bit;
Q : out bit);
end flipflop;

architecture behavioral of flipflop is
begin

process(CLK)
begin
    if CLK 'event and CLK = '1' THEN
        Q <= D;
    end if;
end process;

end behavioral;