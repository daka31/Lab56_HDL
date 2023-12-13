module Mux_2to1 
    #(parameter nBit = 32)(
    output [nBit-1:0] out,
    input [nBit-1:0] in0,
    input [nBit-1:0] in1,
    input sel
    );
    assign out = sel ? in1 : in0;
endmodule