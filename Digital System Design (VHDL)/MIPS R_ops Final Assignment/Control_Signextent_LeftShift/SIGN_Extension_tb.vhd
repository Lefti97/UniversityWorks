LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity test_SIGN_Extension is
end test_SIGN_Extension;

architecture tb of test_SIGN_Extension is
    component SIGN_Extension is port(
        Instr_15to0 : in std_logic_vector (15 downto 0);
        Sign_extended: out std_logic_vector (31 downto 0));
    end component;

    signal Instr_15to0t  : std_logic_vector (15 downto 0);
    signal Sign_extendedt: std_logic_vector (31 downto 0);
begin
    pMap: SIGN_Extension port map(
        Instr_15to0 => Instr_15to0t, Sign_extended => Sign_extendedt);
    process begin
        Instr_15to0t <= x"0010"; wait for 100 ps;
        Instr_15to0t <= x"1001"; wait for 100 ps;
        Instr_15to0t <= x"80A0"; wait for 100 ps;
    end process;
end tb;