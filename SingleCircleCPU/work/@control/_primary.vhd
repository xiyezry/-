library verilog;
use verilog.vl_types.all;
entity Control is
    port(
        Opcode          : in     vl_logic_vector(5 downto 0);
        Funct           : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic;
        MemRead         : out    vl_logic;
        MemtoReg        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(3 downto 0);
        MemWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegWrite        : out    vl_logic;
        EXTOP           : out    vl_logic;
        NPCOP           : out    vl_logic_vector(1 downto 0);
        Zero            : in     vl_logic;
        ShiftIndex      : out    vl_logic;
        ShiftDirection  : out    vl_logic;
        SArith          : out    vl_logic;
        ALUasrc         : out    vl_logic;
        call            : out    vl_logic
    );
end Control;
