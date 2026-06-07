module rca_cluster_ex2 (input clk, rst, output reg q);
 reg d;
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else q <= d;
 end endmodule
