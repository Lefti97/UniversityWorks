LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test_ALU4 is
end test_ALU4;

architecture tb of test_ALU4 is

signal tALUin1 : std_logic_vector (3 downto 0);
signal tALUin2 : std_logic_vector (3 downto 0);
signal tALUctrl: std_logic_vector (3 downto 0);
signal tALUout1: std_logic_vector(3 downto 0);
signal tzero   : std_logic;

component ALU4 port(
    ALUin1 : in std_logic_vector (3 downto 0);
    ALUin2 : in std_logic_vector (3 downto 0);
    ALUctrl: in std_logic_vector (3 downto 0);
    ALUout1: out std_logic_vector(3 downto 0);
    zero   : out std_logic);
end component;

begin
    p1: ALU4 PORT MAP(ALUin1=>tALUin1, ALUin2=>tALUin2, ALUctrl=>tALUctrl, 
                    ALUout1=>tALUout1, zero=>tzero);
process
begin
    tALUin1 <= "0010";
    tALUin2 <= "0100";
    tALUctrl<= "0010";
    wait for 50 ps;
    tALUin1 <= "0100";
    tALUin2 <= "1111";
    tALUctrl<= "0000";
    wait for 50 ps;
    tALUin1 <= "0100";
    tALUin2 <= "1111";
    tALUctrl<= "0001";
    wait for 50 ps;
    tALUin1 <= "0100";
    tALUin2 <= "0010";
    tALUctrl<= "0110";
    wait for 50 ps;
    tALUin1 <= "0100";
    tALUin2 <= "0110";
    tALUctrl<= "0110";
    wait for 50 ps;
    tALUin1 <= "0100";
    tALUin2 <= "0110";
    tALUctrl<= "0111";
    wait for 50 ps;

end process;
end tb;