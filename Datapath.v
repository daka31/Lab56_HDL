`timescale 1ns/100ps

module Datapath(clk, op, rs, rt, rd, shamt, funct, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, RD1, RD2, ALU_result, WD);
  input clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg;
  input [3:0] ALUcontrol;
  input [5:0] op, funct;
  input [4:0] rs, rt, rd, shamt;
  output is0;

  wire [4:0] out_RegDst;
  wire [31:0] out_ALUSrc;

  wire [31:0] out_signex, ReadDataMem; 
  output [31:0] RD1, RD2, ALU_result, WD;

  Mux_2to1 #(.nBit(5)) muxRegDst (
    .out(out_RegDst),
    .in0(rt),
    .in1(rd),
    .sel(RegDst)
  );

  RegisterFile RF(clk, RegWrite, rs, rt, out_RegDst, WD, RD1, RD2);

  SignExtend se({rd, shamt, funct}, out_signex);

  Mux_2to1 #(.nBit(32)) muxALUSrc (
    .out(out_ALUSrc),
    .in0(RD2),
    .in1(out_signex),
    .sel(ALUSrc)
  );

  ALU_32bit ALU(ALUcontrol, RD1, out_ALUSrc, is0, ALU_result);

  DataMemory DM(clk, MemRead, MemWrite, ALU_result[5:0], RD2, ReadDataMem);

  Mux_2to1 #(.nBit(32)) muxMemtoReg (
    .out(WD),
    .in0(ReadDataMem),
    .in1(ALU_result),
    .sel(MemtoReg)
  );
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
  wire [31:0] RD1, RD2, ALU_result, WD;
  
  Datapath DP(clk, op, rs, rt, rd, shamt, funct, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, RD1, RD2, ALU_result, WD);
  
  initial forever #5 clk = ~clk;

  initial begin
    $display("----------------------TEST BENCH FOR DATAPATH----------------------");
    $monitor("%0t# op = %0d, RD1 = %0d, RD2 = %0d, ALU_result = %0d, WD = %0d", $time, op, RD1, RD2, ALU_result, WD);  
    
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
endmodule