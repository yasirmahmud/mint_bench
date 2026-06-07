`timescale 1ns/1ps

module clockgenmodule (output reg clk_out);
 // SpyGlass rule STARC-1.6.1.4 states that #delay is prohibited in always statements
 // but allowed in initial statements for clock generation in testbenches.
 // This change addresses STARC-1.6.1.4, W122, W421, and the CombLoop error
 // by moving the clock generation to an 'initial' block using 'forever'.
 initial begin
  clk_out = 0;
  forever #5 clk_out = ~clk_out;
 end
endmodule
