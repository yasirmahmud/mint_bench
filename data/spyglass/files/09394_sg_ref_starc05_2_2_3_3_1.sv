module STARC05_2_2_3_3_ex1 (input clk, rst_n, d, output reg q);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin q <= 1'b0;
 q <= 1'b1;
 end else begin q <= d;
 end end endmodule
