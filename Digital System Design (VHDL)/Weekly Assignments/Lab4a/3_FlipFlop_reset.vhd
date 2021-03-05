entity flipflop is port (
D : in bit;
CLK : in bit;
Rstn: in bit;
Q : out bit);
end flipflop;

architecture behavioral_res of flipflop is
begin

process(CLK,Rstn)
begin
    if Rstn = '0' THEN
        Q <= '0';
    elsif CLK 'event and CLK = '1' THEN
        Q <= D;
    end if;
end process;

end behavioral_res;