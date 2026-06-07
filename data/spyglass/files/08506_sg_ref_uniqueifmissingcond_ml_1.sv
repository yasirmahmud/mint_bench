module lint_unique_if_missing_cond_ex1 (input [1:0] sel, output reg out);
 always @* begin unique if (sel == 2'b00) begin out = 1'b0;
 end else if (sel == 2'b01) begin out = 1'b1;
 end end endmodule
