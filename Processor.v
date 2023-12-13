`timescale 1ns/100ps
module Processor(clk, op, rs, rt, rd, shamt, funct, is0, RD1, RD2, ALU_result, WD);
  input clk;
  input [5:0] op, funct;
  input [4:0] rs, rt, rd, shamt;
  output is0;
  output [31:0] RD1, RD2, ALU_result, WD;
  
  wire RegDst, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite;
  wire [1:0] ALUOp;
  wire [3:0] ALUcontrol;
  
  ControlUnit CU(op, RegDst, MemRead, MemWrite, MemtoReg, ALUOp, ALUSrc, RegWrite);
  
  ALU_ControlUnit ACU(ALUOp, ALUcontrol);
  
  Datapath DP0(clk, op, rs, rt, rd, shamt, funct, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, RD1, RD2, ALU_result, WD);
  
endmodule

module Processor_tb();
  reg clk;
  reg [5:0] op, funct;
  reg [4:0] rs, rt, rd, shamt;
  wire is0;
  wire [31:0] RD1, RD2, ALU_result, WD;
  
  reg RegDst, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite;
  reg [1:0] ALUOp;
  reg [3:0] ALUcontrol;
  
  Processor P0(clk, op, rs, rt, rd, shamt, funct, is0, RD1, RD2, ALU_result, WD);
  
  initial begin
    clk = 0;  
    forever #5 clk = ~clk;
    //$display("Time = %t, RD1 = %d, RD2 = %d, ALU_result = %d, WD = %d", $time, RD1, RD2, ALU_result, WD);
  end
  
  initial begin
    //add $1, $2, $3;
    op = 6'h01;
    rs = 5'd2;
    rt = 5'd3;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 6'b0;
    $display("%0t# add $%0d, $%0d, $%0d", $time, rd, rs, rt);
    
    #10 //sw $1, 0($2)
    op = 6'h02; 
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 6'b0;
    $display("%0t# sw $%0d, 0($%0d)", $time, rt, rs);
    
    #10 //lw $1, 0($2);
    op = 6'h04; 
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 6'b0;
    $display("%0t# lw $%0d, 0($%0d)", $time, rt, rs);
    
    #10
    op = 6'h01; //add $1, $1, $2;
    rs = 5'd1;
    rt = 5'd2;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 6'b0;
    $display("%0t# add $%0d, $%0d, $%0d", $time, rd, rs, rt);
    
    #10
    $finish;
  end
//  initial begin
//    $monitor("Time = %t, RD1 = %d, RD2 = %d, ALU_result = %d", $time, RD1, RD2, ALU_result);
//  end
endmodule