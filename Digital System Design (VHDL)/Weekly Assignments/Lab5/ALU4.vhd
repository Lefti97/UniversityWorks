LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU4 is port (
    ALUin1 : in std_logic_vector (3 downto 0);
    ALUin2 : in std_logic_vector (3 downto 0);
    ALUctrl: in std_logic_vector (3 downto 0);
    ALUout1: out std_logic_vector(3 downto 0);
    zero   : out std_logic);
end ALU4;

architecture behavioural of ALU4 is
    signal sig: std_logic_vector(3 downto 0);
begin
    process(ALUin1, ALUin2, ALUctrl, sig)
    begin
        if    ALUctrl = "0000" THEN
            sig <= ALUin1 AND ALUin2;
        elsif ALUctrl = "0001" THEN
            sig <= ALUin1 OR  ALUin2;
        elsif ALUctrl = "0010" THEN
            sig <= std_logic_vector(signed(ALUin1) + signed(ALUin2));
        elsif ALUctrl = "0110" THEN
            sig <= std_logic_vector(signed(ALUin1) - signed(ALUin2));
        elsif ALUctrl = "0111" THEN
            if ALUin1 < ALUin2 THEN
                sig <= "0001";
            else
                sig <= "0000";
            end if;
        end if;

        if sig = "0000" THEN
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

    ALUout1 <= sig; 
end behavioural;