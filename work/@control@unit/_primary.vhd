library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    port(
        op              : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic;
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        MemtoReg        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(1 downto 0);
        ALUSrc          : out    vl_logic;
        RegWrite        : out    vl_logic
    );
end ControlUnit;
