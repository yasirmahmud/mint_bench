`timescale 1ns/1ps
module diff_delay_in_non_block_ex2(input clk, input d);
 reg q1, q2;
 reg dummy_q2_reader; // Added to consume q2 for linting

 always @(posedge clk) begin
  q1 <= #1 d;
  q2 <= #2 q1;
  dummy_q2_reader <= q2; // Reads q2 to resolve W528 violation
 end
endmodule
