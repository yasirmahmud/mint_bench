module unused_rtl_code_ex2 (input clk, output reg out);
 reg my_unassigned_reg;
 always @(posedge clk) begin out <= my_unassigned_reg;
 end endmodule
