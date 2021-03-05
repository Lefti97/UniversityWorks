library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
entity MIPS is port(
    CLKm : in std_logic;
    ResetM : in std_logic;
    Instruction : out std_logic_vector(31 downto 0);
    ReadAdd1 : out std_logic_vector(4 downto 0);
    ReadAdd2 : out std_logic_vector(4 downto 0);
    WriteAddr : out std_logic_vector(4 downto 0);
    Register1 : out std_logic_vector(31 downto 0);
    Register2 : out std_logic_vector(31 downto 0);
    outMIPS : out std_logic_vector(31 downto 0));
end MIPS;
architecture MIPS_1 of MIPS is
    component ALU32 port(
        ALUin1: in std_logic_vector(31 downto 0);
        ALUin2: in std_logic_vector(31 downto 0);
        ALUctrl: in std_logic_vector(3 downto 0);
        ALUout1: out std_logic_vector(31 downto 0);
        zero: out std_logic);
    end component;
    component regfile_ext
        generic ( dw   : natural := 32;
                size   : natural := 32;
                adrw   : natural := 5);
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
    component instrMemory port(
        Addr : in std_logic_vector(3 downto 0);
        C : out std_logic_vector(31 downto 0));
    end component;
    component Control port(
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst, RegWrite, ALUSrc, Branch: OUT STD_LOGIC;
        MemRead, MemWrite, MemtoReg:      OUT STD_LOGIC;
        ALU_op: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
    end component;
    component ALU_Control port(
        OP_5to0: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        ALU_op: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Operation: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    end component;
    component PC port(
        CLK : in std_logic;
        Rst : in std_logic;
        inPC: in std_logic_vector(3 downto 0);
        outPC : out std_logic_vector(3 downto 0));
    end component;
    component adder port(
        inp : in  std_logic_vector(3 downto 0);
        outp: out std_logic_vector(3 downto 0));
    end component;
    signal ADDERtoPC  : std_logic_vector(3 downto 0);
    signal PCoutput   : std_logic_vector(3 downto 0);
    signal INSTR31to0 : std_logic_vector(31 downto 0);
    signal RegDst1, RegWrite1, ALUSrc1, Branch1: STD_LOGIC;
    signal MemRead1, MemWrite1, MemtoReg1      : STD_LOGIC;
    signal ALU_op1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal regOUT1 : std_logic_vector(31 downto 0);
    signal regOUT2 : std_logic_vector(31 downto 0);
    signal Operation1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal ALUoutput1 : std_logic_vector(31 downto 0);
    signal ALUzero : std_logic;
begin
    ADDER_MAP : adder port map(inp=>PCoutput, outp=>ADDERtoPC);
    PC_MAP : PC port map(
        CLK => CLKm, Rst => ResetM, inPC => ADDERtoPC, outPC => PCoutput);
    INSTR_MAP : instrMemory port map( Addr => PCoutput,C => INSTR31to0);
    CONTROL_MAP : Control port map(
        OP_5to0=>INSTR31to0(31 downto 26),
        RegDst=>RegDst1, RegWrite=>RegWrite1, ALUSrc=>ALUSrc1, 
        Branch=>Branch1, MemRead=>MemRead1, MemWrite=>MemWrite1,
        MemtoReg=>MemtoReg1, ALU_op=>ALU_op1);
    REG_MAP : regfile_ext port map(
        Datain=>ALUoutput1,
        rAddr1=>INSTR31to0(25 downto 21), rAddr2=>INSTR31to0(20 downto 16),
        wAddr =>INSTR31to0(15 downto 11),
        we=>RegWrite1, clk=>CLKm, reset=>ResetM,
        Dataout1=>regOUT1, Dataout2=>regOUT2);
    ALUCtrl_MAP : ALU_Control port map(
        OP_5to0=>INSTR31to0(5 downto 0), ALU_op=>ALU_op1, Operation=>Operation1);
    ALU32_MAP : ALU32 port map(
        ALUin1=>regOUT1, ALUin2=>regOUT2, ALUctrl=>Operation1,
        ALUout1=>ALUoutput1, zero=>ALUzero);
    Instruction <= INSTR31to0;
    ReadAdd1 <= INSTR31to0(25 downto 21); ReadAdd2 <= INSTR31to0(20 downto 16);
    WriteAddr <= INSTR31to0(15 downto 11);
    Register1 <= regOUT1; Register2 <= regOUT2; outMIPS <= ALUoutput1;
end MIPS_1;