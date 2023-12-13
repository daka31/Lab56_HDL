`timescale 1ns/100ps

module ALU_32bit(op, a, b, is0, result);
  input [3:0] op;
  input [31:0] a, b;
  output is0;
  output reg [31:0] result;

  always @(*) begin
    case(op)
      4'b0000 : result = ~a;
		  4'b0001 : result = a & b;
		  4'b0010 : result = a ^ b;
		  4'b0011 : result = a | b;
		  4'b0100 : result = a - 32'b1;
		  4'b0101 : result = a + b;
		  4'b0110 : result = a - b;
		  4'b0111 : result = a + 32'b1;
		  default : result = 32'bx;
    endcase
  end
  assign is0 = (result == 32'b0) ? 1 : 0;
endmodule