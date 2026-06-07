module STARC05_2_3_2_2_ex1 (input clk, in, output reg out1, out2);
 always @(posedge clk) begin out1 = in;
 out2 <= in;
 end endmodule
