module maxfanin_logic_ex1 (input clk, input rst, input [1024:0] d_in, output reg q);
 wire d_combined;
 assign d_combined = |d_in;
 always @(posedge clk or posedge rst) begin if (rst) begin q <= 1'b0;
 end else begin q <= d_combined;
 end endmodule
