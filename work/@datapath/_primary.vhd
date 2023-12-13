library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        clk             : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        rs              : in     vl_logic_vector(4 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        RegDst          : in     vl_logic;
        RegWrite        : in     vl_logic;
        ALUSrc          : in     vl_logic;
        ALUcontrol      : in     vl_logic_vector(3 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        MemtoReg        : in     vl_logic;
        is0             : out    vl_logic;
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ReadData2       : out    vl_logic_vector(31 downto 0);
        ALU_result      : out    vl_logic_vector(31 downto 0);
        out_MemtoReg    : out    vl_logic_vector(31 downto 0)
    );
end Datapath;
