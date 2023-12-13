library verilog;
use verilog.vl_types.all;
entity ALU_32bit is
    port(
        op              : in     vl_logic_vector(3 downto 0);
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        is0             : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0)
    );
end ALU_32bit;
