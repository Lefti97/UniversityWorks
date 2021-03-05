LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity test_ALUctr is
end test_ALUctr;

architecture tb of test_ALUctr is
    signal tOP_5to0: STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal tALU_op : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal tOper   : STD_LOGIC_VECTOR(3 DOWNTO 0);

    component ALU_Control PORT (
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Operation: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END component;
begin
    portMap: ALU_Control port map (OP_5to0 => tOP_5to0, ALU_op => tALU_op, Operation => tOper);
    
    process begin
        tALU_op <= "00"; tOP_5to0 <= "001001";
        wait for 100 ps;
        tALU_op <= "00"; tOP_5to0 <= "001010";
        wait for 100 ps;
        tALU_op <= "01"; tOP_5to0 <= "100111";
        wait for 100 ps;
        tALU_op <= "10"; tOP_5to0 <= "100000";
        wait for 100 ps;
        tALU_op <= "10"; tOP_5to0 <= "100010";
        wait for 100 ps;
        tALU_op <= "10"; tOP_5to0 <= "100100";
        wait for 100 ps;
        tALU_op <= "10"; tOP_5to0 <= "100101";
        wait for 100 ps;
        tALU_op <= "10"; tOP_5to0 <= "101010";
        wait for 100 ps;
    end process;
end tb;