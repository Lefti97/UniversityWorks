library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity test_regfile is
end test_regfile;

architecture tb of test_regfile is

signal tA    : std_logic_vector(3 downto 0);
signal tAddr : std_logic_vector(1 downto 0);
signal twe   : std_logic;
signal tclk  : std_logic;
signal tC    : std_logic_vector(3 downto 0);

component regfile
    generic ( 
        dw   : natural := 4;
        size : natural := 4;
        adrw : natural := 2);
    port ( 
        A    : in  std_logic_vector(dw-1 downto 0);
        Addr : in  std_logic_vector(adrw-1 downto 0);
        we   : in  std_logic;
        clk  : in  std_logic;
        C    : out std_logic_vector(dw-1 downto 0));
end component;

begin
    p1: regfile port map(A=>tA, Addr=>tAddr, we=>twe, clk=>tclk, C=>tC);
process
begin
    twe<='1';
    tAddr<="00";
    tA<="0101";
    tclk<='1';
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tAddr<="01";
    tA<="1101";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tAddr<="10";
    tA<="0010";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tAddr<="11";
    tA<="1001";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    twe<='0';
    tAddr<="01";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tAddr<="11";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
end process;
end tb;