`timescale 1ns/100ps

module Mux21_32bit(sel, a, b, out);
  input sel;
  input [31:0] a, b;
  output [31:0] out;
  
  assign out = (sel == 0) ? a : b;
endmodule
