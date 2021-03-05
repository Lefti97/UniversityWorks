LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SIGN_Extension is port (
    Instr_15to0 : in std_logic_vector (15 downto 0);
    Sign_extended: out std_logic_vector (31 downto 0));
END SIGN_Extension;

architecture s_ext of SIGN_Extension is
begin
    Sign_extended <=
        x"0000" & Instr_15to0 when Instr_15to0(15)='0' else
        x"FFFF" & Instr_15to0 when Instr_15to0(15)='1';
end s_ext;