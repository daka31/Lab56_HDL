library verilog;
use verilog.vl_types.all;
entity RAM is
    port(
        clk             : in     vl_logic;
        cs              : in     vl_logic;
        wr_e            : in     vl_logic;
        oe              : in     vl_logic;
        addr            : in     vl_logic_vector(6 downto 0);
        data            : inout  vl_logic_vector(7 downto 0)
    );
end RAM;
