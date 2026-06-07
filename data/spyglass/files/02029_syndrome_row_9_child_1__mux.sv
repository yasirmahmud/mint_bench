`timescale 1ns/1ps

// Definition for mux module to resolve ErrorAnalyzeBBox violation
module mux(input [12:0] alpha, input r, output [12:0] out);
  assign out = r ? alpha : 13'b0;
endmodule
