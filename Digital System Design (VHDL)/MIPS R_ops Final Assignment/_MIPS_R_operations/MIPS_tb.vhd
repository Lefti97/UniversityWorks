library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity test_mips is
end test_mips;
architecture tb of test_mips is
    component MIPS is port(
        CLKm : in std_logic;
        ResetM : in std_logic;
        Instruction : out std_logic_vector(31 downto 0);
        ReadAdd1 : out std_logic_vector(4 downto 0);
        ReadAdd2 : out std_logic_vector(4 downto 0);
        WriteAddr : out std_logic_vector(4 downto 0);
        Register1 : out std_logic_vector(31 downto 0);
        Register2 : out std_logic_vector(31 downto 0);
        outMIPS : out std_logic_vector(31 downto 0));
    end component;
    signal Clock, Rst : std_logic;
    signal tInstr, Reg1, Reg2, out1 : std_logic_vector(31 downto 0);
    signal ReadAddr1, ReadAddr2, WriteAdd : std_logic_vector(4 downto 0);
begin
    MIPS_MAPS : MIPS port map(
        CLKm=>Clock, ResetM=>Rst, Instruction=>tInstr,
        ReadAdd1=>ReadAddr1, ReadAdd2=>ReadAddr2, WriteAddr=>WriteAdd,
        Register1=>Reg1, Register2=>Reg2, outMIPS=>out1);
    process begin
        Rst<='1';
        Clock<='0'; wait for 50 ps; Clock<='1'; wait for 50 ps;
        Rst<='0';
        Clock<='0'; wait for 50 ps; Clock<='1'; wait for 50 ps;
        Clock<='0'; wait for 50 ps; Clock<='1'; wait for 50 ps;
        Clock<='0'; wait for 50 ps; Clock<='1'; wait for 50 ps;
    end process;
end tb;