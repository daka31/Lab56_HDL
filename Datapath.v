`timescale 1ns/100ps

module Datapath(clk, Instruction, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, RD1, RD2, ALU_result, WD);
  input clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg;
  input [3:0] ALUcontrol;
  input [25:0] Instruction;
  output is0;
  output [31:0] RD1, RD2, ALU_result, WD;  
  wire [4:0] out_RegDst;
  wire [31:0] out_ALUSrc;
  wire [31:0] out_signex, ReadDataMem; 

  Mux_2to1 #(.nBit(5)) muxRegDst (
    .out(out_RegDst),
    .in0(Instruction[20:16]),
    .in1(Instruction[15:11]),
    .sel(RegDst)
  );

  RegisterFile registers (
    .clk(clk),
    .RegWrite(RegWrite),
    .RR1(Instruction[25:21]),
    .RR2(Instruction[20:16]),
    .WR(out_RegDst),
    .WD(WD),
    .RD1(RD1),
    .RD2(RD2));

  SignExtend se(Instruction[15:0], out_signex);

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
  wire is0;
  reg clk, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg;
  reg [3:0] ALUcontrol;
  reg [4:0] rs, rt, rd;
  reg[25:0] Instruction; 
  wire [31:0] RD1, RD2, ALU_result, WD;

  Datapath DP(clk, Instruction, RegDst, RegWrite, ALUSrc, ALUcontrol, MemRead, MemWrite, MemtoReg, is0, RD1, RD2, ALU_result, WD);
  
  initial forever #5 clk = ~clk;

  initial begin
    $display("----------------------TEST BENCH FOR DATAPATH----------------------");
    $monitor("%0t# RD1 = %0d, RD2 = %0d, ALU_result = %0d, WD = %0d", $time, RD1, RD2, ALU_result, WD);  
    
    clk = 0;
    rs = 5'd2;
    rt = 5'd3;
    rd = 5'd1;
    Instruction = {rs, rt, rd, 11'b0};
    RegDst = 1;
    RegWrite = 1;
    ALUSrc = 0;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 0;
    MemtoReg = 1;
    $display("%0t# add $%0d, $%0d, $%0d", $time, rd, rs, rt);
    
    #10
    rs = 5'd2;
    rt = 5'd1;
    Instruction = {rs, rt, 16'b0};
    RegDst = 0;
    RegWrite = 0;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 0;
    MemWrite = 1;
    MemtoReg = 1'bx;
    $display("%0t# sw $%0d, 0($%0d)", $time, rt, rs);
    
    #10
    rs = 5'd2;
    rt = 5'd4;
    rd = 5'd0;
    Instruction = {rs, rt, 16'b0};
    RegDst = 0;
    RegWrite = 1;
    ALUSrc = 1;
    ALUcontrol = 4'b0101;
    MemRead = 1;
    MemWrite = 0;
    MemtoReg = 1;
    $display("%0t# lw $%0d, 0($%0d)", $time, rt, rs);

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