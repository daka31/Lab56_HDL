`timescale 1ns/100ps

module DataMemory(clk, MemRead, MemWrite, Address, WriteData, ReadData);
  input clk, MemRead, MemWrite;
  input [5:0] Address;
  input [31:0] WriteData;
  output reg [31:0] ReadData;
  reg [31:0] Mem [63:0];
  
  always @(posedge clk) begin
    if(MemWrite) begin
      Mem[Address] = WriteData;
      $display("%0t# @WRITE Mem[%0d] = %0d", $time, Address, WriteData);
    end
  end
  always @(*) begin
    if(MemRead) begin
      ReadData = Mem[Address];
      $display("%0t# @READ Mem[%0d] = %0d", $time, Address, ReadData);
    end
  end
endmodule

module DataMemory_tb();
  reg clk, MemRead, MemWrite;
  reg [5:0] Address;
  reg [31:0] WriteData;
  wire [31:0] ReadData;
  
  DataMemory DMem(clk, MemRead, MemWrite, Address, WriteData, ReadData);
  
  initial begin
    forever #5 clk = ~clk;
  end
  initial begin
    clk = 0;
    Address = 6'd2;
    MemRead = 0;
    MemWrite = 1;
    WriteData = 32'h12345678;
    
    #10
    Address = 6'd2;
    MemRead = 1;
    MemWrite = 0;
    
    #10
    Address = 6'd3;
    MemRead = 0;
    MemWrite = 1;
    WriteData = 32'h87654321;
    
    #10
    Address = 6'd3;
    MemRead = 1;
    MemWrite = 0;
    
    #10
    $finish;
  end
  initial begin
    $monitor("Time = %t, Address = %d, MemRead = %b, MemWrite = %b, WriteData = %h, ReadData = %h", $time, Address, MemRead, MemWrite, WriteData, ReadData);
  end
endmodule
