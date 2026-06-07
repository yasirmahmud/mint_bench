module STARC05_2_3_1_2vc_ex1 (input [1:0] clk_multi, input rst_n, input d, output reg q);
 always @(posedge clk_multi) begin q <= d;
 end endmodule
