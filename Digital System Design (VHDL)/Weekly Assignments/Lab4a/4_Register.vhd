entity register1 is port (
D : in bit_vector(3 downto 0);
clk : in bit;
clr : in bit;
Q : out bit_vector(3 downto 0));
end register1;

architecture behavioral of register1 is
begin
process(clk,clr)
begin
    if clr = '1' THEN
        Q <= "0000";
    elsif clk 'event and clk = '1'THEN
        Q <= D; 
    end if;
end process;
end behavioral;