library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
entity test_regfile_ext is end test_regfile_ext;
architecture tb of test_regfile_ext is
    constant dw1, size1   : natural := 4;
    constant adrw1 : natural := 2;
    signal tDatain    : std_logic_vector(dw1-1 downto 0);
    signal tRAddr1, tRAddr2 : std_logic_vector(adrw1-1 downto 0);
    signal tWAddr : std_logic_vector(adrw1-1 downto 0);
    signal twe, tclk, trst   : std_logic;
    signal tDataout1, tDataout2    : std_logic_vector(dw1-1 downto 0);
    component regfile_ext
        generic ( dw   : natural := 4;
                size   : natural := 4;
                adrw   : natural := 2);
        port (  Datain : in std_logic_vector(dw-1 downto 0);
                rAddr1 : in std_logic_vector(adrw-1 downto 0);
                rAddr2 : in std_logic_vector(adrw-1 downto 0);
                wAddr  : in std_logic_vector(adrw-1 downto 0);
                we     : in std_logic;
                clk    : in std_logic;
                reset  : in std_logic;
                Dataout1 : out std_logic_vector(dw-1 downto 0);
                Dataout2 : out std_logic_vector(dw-1 downto 0));
    end component;
begin
    p1: regfile_ext generic map(dw=>dw1, size=>size1, adrw=>adrw1)
        port map(Datain=>tDatain, rAddr1=>tRAddr1, rAddr2=>tRAddr2, wAddr=>tWAddr, 
        we=>twe, clk=>tclk, reset=>trst, Dataout1=>tDataout1, Dataout2=>tDataout2);
    process begin
        trst<='0'; twe<='1'; 
        tWAddr<="00"; tDatain<="0101"; 
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
        tWAddr<="01"; tDatain<="1101"; 
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
        tWAddr<="10"; tDatain<="0010"; 
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
        tWAddr<="11"; tDatain<="1001"; 
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
        twe<='0'; tRAddr1<="00"; tRAddr2<="10";
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
        tRAddr1<="01"; tRAddr2<="10";
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
            tclk<='1'; wait for 50 ps; tclk<='0'; wait for 50 ps;
    end process;
end tb;