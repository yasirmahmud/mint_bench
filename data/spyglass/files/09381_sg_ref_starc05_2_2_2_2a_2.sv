module lint_star_ex2 (input a, input b, output reg out);
 always @(a or b) begin out = a;
 end endmodule
