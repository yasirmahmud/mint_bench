`timescale 1ns/1ps
module waveform_ex2(input clk, input in1, input in2, output reg out);
 always @(posedge clk) begin
  out <= in2;
 end
endmodule
