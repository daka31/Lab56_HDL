library verilog;
use verilog.vl_types.all;
entity Mux21_5bit is
    port(
        sel             : in     vl_logic;
        a               : in     vl_logic_vector(4 downto 0);
        b               : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(4 downto 0)
    );
end Mux21_5bit;
