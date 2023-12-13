`timescale 1ns/100ps

module Datapath(clk, op, rs, rt, rd, shamt, funct, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, ReadData1, ReadData2, ALU_result, out_MemtoReg);
  input clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg;
  input [3:0] ALUcontrol;
  input [5:0] op, funct;
  input [4:0] rs, rt, rd, shamt;
  output is0;

  wire [4:0] out_RegDst;
  wire [31:0] out_ALUSrc;

  wire [31:0] out_signex, ReadDataMem; 
  output [31:0] ReadData1, ReadData2, ALU_result, out_MemtoReg;

  Mux21_5bit mux0(RegDst, rt, rd, out_RegDst);

  RegisterFile RF(clk, RegWrite, rs, rt, out_RegDst, out_MemtoReg, ReadData1, ReadData2);

  SignExtend se({rd, shamt, funct}, out_signex);

  Mux21_32bit mux1(ALUSrc, ReadData2, out_signex, out_ALUSrc);

  ALU_32bit ALU(ALUcontrol, ReadData1, out_ALUSrc, is0, ALU_result);

  DataMemory DM(clk, MemRead, MemWrite, ALU_result[5:0], ReadData2, ReadDataMem);

  Mux21_32bit mux2(MemtoReg, ReadDataMem, ALU_result, out_MemtoReg);
endmodule

module Datapath_tb();
  reg clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg;
  reg [3:0] ALUcontrol;
  reg [5:0] op, funct;
  reg [4:0] rs, rt, rd, shamt;
  wire is0;
  reg [4:0] out_RegDst;
  wire  [31:0] out_ALUSrc;
  reg [31:0] out_signex, ReadDataMem; 
  wire [31:0] ReadData1, ReadData2, ALU_result, out_MemtoReg;
  
  Datapath DP(clk, op, rs, rt, rd, shamt, funct, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, ReadData1, ReadData2, ALU_result, out_MemtoReg);
  
  initial begin
    forever #5 clk = ~clk;
  end
  
  initial begin
    clk = 0;
    op = 6'h01;
    rs = 5'd2;
    rt = 5'd3;
    rd = 5'd1;
    shamt = 5'd0;
    funct = 5'd0;
    RegDst = 1;
    RegWrite = 1;
    ALUSrc = 0;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 0;
    MemtoReg = 1;
    
    #10
    op = 6'h02;
    rs = 5'd2;
    rt = 5'd1;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    RegDst = 0;
    RegWrite = 0;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 1;
    MemtoReg = 0;
    
    #10
    op = 6'h04;
    rs = 5'd2;
    rt = 5'd4;
    rd = 5'd0;
    shamt = 5'd0;
    funct = 5'd0;
    RegDst = 0;
    RegWrite = 1;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 1;
    MemWrite = 0;
    MemtoReg = 0;
    //
//    #10
//    op = 6'h00;
//    rs = 5'd4;
//    rt = 5'd3;
//    rd = 5'd1;
//    shamt = 5'd0;
//    funct = 5'd0;
//    RegDst = 1;
//    RegWrite = 1;
//    ALUSrc = 0;
//    ALUcontrol = 4'b0101;
//    MemRead = 0;
//    MemWrite = 0;
//    MemtoReg = 1;
    
    
    
    #10
    $finish;
  end
  initial begin
    $monitor("Time = %t, ReadData1 = %d, ReadData2 = %d, ALU_result = %d, out_MemtoReg = %d", $time, ReadData1, ReadData2, ALU_result, out_MemtoReg);
  end
endmodule