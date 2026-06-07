module w442a_violation_ex2 (input clk, input rst, input d, output reg q);
 always @(posedge clk or negedge rst) begin q <= d;
 end endmodule
