library verilog;
use verilog.vl_types.all;
entity Processor is
    port(
        clk             : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        rs              : in     vl_logic_vector(4 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        shamt           : in     vl_logic_vector(4 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        is0             : out    vl_logic;
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ReadData2       : out    vl_logic_vector(31 downto 0);
        ALU_result      : out    vl_logic_vector(31 downto 0);
        out_MemtoReg    : out    vl_logic_vector(31 downto 0)
    );
end Processor;
