module lint_logical_expr_ex2 (input clk1, input clk2, input rst, output reg q);
 always @(posedge (clk1 | clk2) or posedge rst) begin if (rst) q <= 1'b0;
 else q <= 1'b1;
 end endmodule
