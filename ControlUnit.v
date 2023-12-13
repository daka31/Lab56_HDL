`timescale 1ns/100ps
module ControlUnit(op, RegDst, MemRead, MemWrite, MemtoReg, ALUOp, ALUSrc, RegWrite);
  input [5:0] op;
  output reg RegDst, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite;
  output reg [1:0] ALUOp;
  
  always @(*) begin
    case(op)
      6'h01 : begin //add
        RegDst = 1;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 1;
        ALUOp = 2'b10;
        ALUSrc = 0;
        RegWrite = 1;
      end
      6'h02 : begin //sw
        RegDst = 0;
        MemRead = 0;
        MemWrite = 1;
        MemtoReg = 0;
        ALUOp = 2'b00;
        ALUSrc = 1;
        RegWrite = 0;
      end
      6'h04 : begin //lw
        RegDst = 0;
        MemRead = 1;
        MemWrite = 0;
        MemtoReg = 0;
        ALUOp = 2'b00;
        ALUSrc = 1;
        RegWrite = 1;
      end
    endcase
  end
endmodule