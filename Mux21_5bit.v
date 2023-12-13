`timescale 1ns/100ps

module Mux21_5bit(sel, a, b, out);
  input sel;
  input [4:0] a, b;
  output [4:0] out;
  
  assign out = (sel == 0) ? a : b;
endmodule