LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TEST_ALUCONTROL_ALU IS PORT (
    OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    ALUin1: in std_logic_vector(3 downto 0);
    ALUin2: in std_logic_vector(3 downto 0);
    ALUout1: out std_logic_vector(3 downto 0);
    zero: out std_logic);
END TEST_ALUCONTROL_ALU;

architecture test_ALUCONTROL_ALU of TEST_ALUCONTROL_ALU is
    component ALU_Control port(
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Operation: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    end component;

    component ALU4 port(
        ALUin1: in std_logic_vector(3 downto 0);
        ALUin2: in std_logic_vector(3 downto 0);
        ALUctrl: in std_logic_vector(3 downto 0);
        ALUout1: out std_logic_vector(3 downto 0);
        zero: out std_logic);
    end component;

    signal ctrl_sig: std_logic_vector(3 downto 0);

begin
    control_ALU : ALU_Control port map(
        OP_5to0=>OP_5to0, ALU_op=>ALU_op, Operation=>ctrl_sig);
    in_ALU : ALU4 port map(
        ALUin1=>ALUin1, ALUin2=>ALUin2, ALUctrl=>ctrl_sig,
        ALUout1=>ALUout1, zero=>zero);
end test_ALUCONTROL_ALU;