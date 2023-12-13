`timescale 1ns/100ps

module RegisterFile(clk, RegWrite, RR1, RR2, WR, WD, RD1, RD2);
  input clk, RegWrite;
  input [4:0] RR1, RR2, WR;
  input [31:0] WD;
  output reg [31:0] RD1, RD2;
  
  reg [31:0] Mem [31:0];
  
  initial begin
    Mem[2] = 2;
    Mem[3] = 3;
  end
  
  always @(*) begin
    RD1 = Mem[RR1];
    RD2 = Mem[RR2];
    //$display("Time = %0t, RD1 = %0d, RD2 = %0d", $time, RD1, RD2);
  end
  
  always @(posedge clk) begin
    if(RegWrite) begin
      Mem[WR] = WD;
      $display("%0t# @WRITE Reg[%0d] = %0d", $time, WR, WD);
    end
  end
  
endmodule

module RegisterFile_tb();
  reg clk, RegWrite;
  reg [4:0] RR1, RR2, WR;
  reg [31:0] WD;
  wire [31:0] RD1, RD2;
  
  RegisterFile RFT(clk, RegWrite, RR1, RR2, WR, WD, RD1, RD2);
  
  initial begin
    forever #5 clk = ~clk;
  end
  initial begin
    clk = 0;
    RR1 = 5'd2;
    RR2 = 5'd3;
    WR = 5'd1;
    WD = 32'h12345678;
    RegWrite = 1;
    
    #10
    RR1 = 5'd1;
    RR2 = 5'd2;
    WR = 5'd3;
    WD = 32'h87654321;
    RegWrite = 1;
    
    #10
    RR1 = 5'd2;
    RR2 = 5'd3;
    WR = 5'd1;
    WD = 32'h1234abcd;
    RegWrite = 0;
    
    #10
    RR1 = 5'd1;
    RR2 = 5'd2;
    WR = 5'd1;
    WD = 32'h5678cdef;
    RegWrite = 0;
    
    #10
    $finish;
  end
  initial begin
    $monitor("Time = %t, WR = %b, RR1 = %d, RR2 = %d, WR = %d, WD = %h, RD1 = %h, RD2 = %h", $time, WR, RR1, RR2, WR, WD, RD1, RD2);
  end
  
endmodule