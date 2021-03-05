LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY ALU_Control IS PORT (
    OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    Operation: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END ALU_Control;
architecture ALU_Ctr of ALU_Control is
    signal tmp_op5to0: STD_LOGIC_VECTOR(3 downto 0);
    signal tmp_ALUop: STD_LOGIC_VECTOR(3 downto 0);
begin
    with OP_5to0(3 downto 0) select
        tmp_op5to0 <=
            "0010" when "0000",
            "0110" when "0010",
            "0000" when "0100",
            "0001" when "0101",
            "0111" when "1010",
            "1111" when others;
    with ALU_op select
        tmp_ALUop <=
            "0010" when "00",
            "0110" when "01",
            "1111" when others;
    with ALU_op select
        Operation <=
            tmp_op5to0 when "10",
            tmp_ALUop  when others;
end ALU_Ctr;