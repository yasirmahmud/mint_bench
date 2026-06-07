module hanging_flop_output_ex2 (input clk, input rst, input d);
 reg q;
 always @(posedge clk or posedge rst) begin if (rst) q <= 1'b0;
 else q <= d;
 end endmodule
