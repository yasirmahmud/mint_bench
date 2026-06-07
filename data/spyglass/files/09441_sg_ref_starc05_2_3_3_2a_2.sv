module starc05_2_3_3_2a_ex2 (input clk, input d, output reg q);
always begin @(posedge clk) q <= d;
 @(negedge clk) q <= ~d;
 end endmodule
