LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Control IS PORT (
    OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    RegDst, RegWrite, ALUSrc, Branch: OUT STD_LOGIC;
    MemRead, MemWrite, MemtoReg:      OUT STD_LOGIC;
    ALU_op: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END Control;

architecture control_arch of Control is
begin
    with OP_5to0 select
        RegDst <= '1' when "000000",
                  '0' when others;
    with OP_5to0 select
        ALUSrc <= '1' when "100011",
                  '1' when "101011",
                  '0' when others;
    with OP_5to0 select
        MemtoReg <= '1' when "100011",
                    '0' when others;
    with OP_5to0 select
        RegWrite <= '1' when "000000",
                    '1' when "100011",
                    '0' when others;
    with OP_5to0 select
        MemRead <= '1' when "100011",
                   '0' when others;
    with OP_5to0 select
        MemWrite <= '1' when "101011",
                    '0' when others;
    with OP_5to0 select
        Branch <= '1' when "000100",
                  '0' when others;
    with OP_5to0 select
        ALU_op <= "10" when "000000",
                  "01" when "000100",
                  "00" when others;
end control_arch;