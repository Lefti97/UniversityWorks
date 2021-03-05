library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity test_regfile_ext is
end test_regfile_ext;

architecture tb of test_regfile_ext is

signal tA    : std_logic_vector(3 downto 0);
signal tRAddr1 : std_logic_vector(1 downto 0);
signal tRAddr2 : std_logic_vector(1 downto 0);
signal tWAddr : std_logic_vector(1 downto 0);
signal twe   : std_logic;
signal tclk  : std_logic;
signal trst  : std_logic;
signal teB    : std_logic_vector(3 downto 0);
signal tC    : std_logic_vector(3 downto 0);

component regfile_ext
    generic ( 
        dw   : natural := 4;
        size : natural := 4;
        adrw : natural := 2);
    port ( 
        A     : in  std_logic_vector(dw-1 downto 0);
        rAddr1: in  std_logic_vector(adrw-1 downto 0);
        rAddr2: in  std_logic_vector(adrw-1 downto 0);
        wAddr : in  std_logic_vector(adrw-1 downto 0);
        we    : in  std_logic;
        clk   : in  std_logic;
        reset : in  std_logic;
        B     : out std_logic_vector(dw-1 downto 0);
        C     : out std_logic_vector(dw-1 downto 0));
end component;

begin
    p1: regfile_ext port map
        (A=>tA, rAddr1=>tRAddr1, rAddr2=>tRAddr2, wAddr=>tWAddr, we=>twe, 
        clk=>tclk, reset=>trst, B=>teB, C=>tC);
process
begin
    trst<='0';
    twe<='1';
    tA<="0101";
    tWAddr<="00";
    tclk<='1';
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tA<="1010";
    tWAddr<="01";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tA<="0000";
    tWAddr<="10";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tA<="1111";
    tWAddr<="11";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tRAddr1<="00";
    tRAddr2<="10";
    twe<='0';
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    tRAddr1<="01";
    tRAddr2<="11";
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
    wait for 50 ps; tclk<='0';
    wait for 50 ps; tclk<='1';
end process;
end tb;