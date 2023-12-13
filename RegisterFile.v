`timescale 1ns/100ps

module RegisterFile(clk, RegWrite, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
  input clk, RegWrite;
  input [4:0] ReadReg1, ReadReg2, WriteReg;
  input [31:0] WriteData;
  output reg [31:0] ReadData1, ReadData2;
  
  reg [31:0] Mem [31:0];
  
  initial begin
    Mem[2] = 2;
    Mem[3] = 3;
  end
  
  always @(*) begin
    ReadData1 = Mem[ReadReg1];
    ReadData2 = Mem[ReadReg2];
    //$display("Time = %0t, ReadData1 = %0d, ReadData2 = %0d", $time, ReadData1, ReadData2);
  end
  
  always @(posedge clk) begin
    if(RegWrite) begin
      Mem[WriteReg] = WriteData;
      $display("RegWrite at %0t, RegFile[%0d] = %0d", $time, WriteReg, WriteData);
    end
  end
  
endmodule

module RegisterFile_tb();
  reg clk, RegWrite;
  reg [4:0] ReadReg1, ReadReg2, WriteReg;
  reg [31:0] WriteData;
  wire [31:0] ReadData1, ReadData2;
  
  RegisterFile RFT(clk, RegWrite, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
  
  initial begin
    forever #5 clk = ~clk;
  end
  initial begin
    clk = 0;
    ReadReg1 = 5'd2;
    ReadReg2 = 5'd3;
    WriteReg = 5'd1;
    WriteData = 32'h12345678;
    RegWrite = 1;
    
    #10
    ReadReg1 = 5'd1;
    ReadReg2 = 5'd2;
    WriteReg = 5'd3;
    WriteData = 32'h87654321;
    RegWrite = 1;
    
    #10
    ReadReg1 = 5'd2;
    ReadReg2 = 5'd3;
    WriteReg = 5'd1;
    WriteData = 32'h1234abcd;
    RegWrite = 0;
    
    #10
    ReadReg1 = 5'd1;
    ReadReg2 = 5'd2;
    WriteReg = 5'd1;
    WriteData = 32'h5678cdef;
    RegWrite = 0;
    
    #10
    $finish;
  end
  initial begin
    $monitor("Time = %t, WriteReg = %b, ReadReg1 = %d, ReadReg2 = %d, WriteReg = %d, WriteData = %h, ReadData1 = %h, ReadData2 = %h", $time, WriteReg, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
  end
  
endmodule