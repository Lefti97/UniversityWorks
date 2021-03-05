LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity TB_test_ALUctrl_ALU is
end TB_test_ALUctrl_ALU;

architecture tb of TB_test_ALUctrl_ALU is
    component TEST_ALUCONTROL_ALU port(
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALUin1: in std_logic_vector(3 downto 0);
        ALUin2: in std_logic_vector(3 downto 0);
        ALUout1: out std_logic_vector(3 downto 0);
        zero: out std_logic);
    end component;
    signal tOP_5to0:  STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal tALU_op :  STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tALUin1 :  std_logic_vector(3 downto 0);
    signal tALUin2 :  std_logic_vector(3 downto 0);
    signal tALUout1:  std_logic_vector(3 downto 0);
    signal tzero   :  std_logic;
begin
    tb_Map: TEST_ALUCONTROL_ALU port map(
        OP_5to0=>tOP_5to0, ALU_op=>tALU_op, ALUin1=>tALUin1,
        ALUin2=>tALUin2, ALUout1=>tALUout1, zero=>tzero);
    process begin
        tALUin1<="1100"; tALUin2<="1100";

        tALU_op<="00"; tOP_5to0<="001001"; wait for 100 ps;
        tALU_op<="00"; tOP_5to0<="001010"; wait for 100 ps;
        tALU_op<="01"; tOP_5to0<="100111"; wait for 100 ps;
        tALU_op<="10"; tOP_5to0<="100000"; wait for 100 ps;
        tALU_op<="10"; tOP_5to0<="100010"; wait for 100 ps;
        tALU_op<="10"; tOP_5to0<="100100"; wait for 100 ps;
        tALU_op<="10"; tOP_5to0<="100101"; wait for 100 ps;
        tALU_op<="10"; tOP_5to0<="101010"; wait for 100 ps;
    end process;
end tb;