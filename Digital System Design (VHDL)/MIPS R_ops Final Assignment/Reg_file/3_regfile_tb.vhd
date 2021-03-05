library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity test_regfile is
end test_regfile;
architecture tb of test_regfile is
    component regfile port ( 
        Datain  : in std_logic_vector(3 downto 0);
        Addr    : in std_logic_vector(2 downto 0);
        we      : in std_logic;
        clk     : in std_logic;
        Dataout : out std_logic_vector(3 downto 0));
    end component;
    signal Datain1  : std_logic_vector(3 downto 0);
    signal Addr1    : std_logic_vector(2 downto 0);
    signal we1      : std_logic;
    signal clk1     : std_logic;
    signal Dataout1 : std_logic_vector(3 downto 0);
begin
    p1: regfile port map(
        Datain=>Datain1, Addr=>Addr1, we=>we1, clk=>clk1, Dataout=>Dataout1);
    process begin
        we1<='1';
        Addr1 <= "000"; Datain1 <= "0101";
        clk1<='0'; wait for 50 ps; clk1<='1'; wait for 50 ps;
        Addr1 <= "001"; Datain1 <= "1101";
        clk1<='0'; wait for 50 ps; clk1<='1'; wait for 50 ps;
        Addr1 <= "010"; Datain1 <= "0010";
        clk1<='0'; wait for 50 ps; clk1<='1'; wait for 50 ps;
        Addr1 <= "011"; Datain1 <= "1001";
        clk1<='0'; wait for 50 ps; clk1<='1'; wait for 50 ps;
    end process;
end tb;