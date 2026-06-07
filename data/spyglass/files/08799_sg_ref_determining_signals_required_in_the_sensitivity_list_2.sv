module lint_rule_ex2(input [7:0] in, input [2:0] i, output reg out);
 always @(i) begin out = in[i];
 end endmodule
