`timescale 1ns/100ps

module ALU_ControlUnit(ALUOp, ALUcontrol);
  input [1:0] ALUOp;
  output [3:0] ALUcontrol;
  
  assign ALUcontrol = (ALUOp == 2'b10) ? 4'b0101 : 4'b0101;
  
endmodule