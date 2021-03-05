LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity test_Control is
end test_Control;

architecture tb of test_Control is
    component Control port(
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst, RegWrite, ALUSrc, Branch: OUT STD_LOGIC;
        MemRead, MemWrite, MemtoReg:      OUT STD_LOGIC;
        ALU_op: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
    end component;

    signal OP_5to0t: STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal RegDstt, RegWritet, ALUSrct, Brancht: STD_LOGIC;
    signal MemReadt, MemWritet, MemtoRegt:       STD_LOGIC;
    signal ALU_opt: STD_LOGIC_VECTOR(1 DOWNTO 0);
begin
    pMap : Control port map(
        OP_5to0 => OP_5to0t, RegDst => RegDstt, RegWrite => RegWritet,
        ALUSrc => ALUSrct, Branch => Brancht, MemRead => MemReadt,
        MemWrite => MemWritet, MemtoReg => MemtoRegt, ALU_op => ALU_opt);
    process begin
        OP_5to0t <= "000000"; wait for 100 ps;
        OP_5to0t <= "100011"; wait for 100 ps;
        OP_5to0t <= "101011"; wait for 100 ps;
        OP_5to0t <= "000100"; wait for 100 ps;
    end process;
end tb;