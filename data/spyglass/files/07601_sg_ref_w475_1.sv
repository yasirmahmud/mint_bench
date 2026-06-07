module w475_ex1(input clk);
 reg my_reg;
 always @(posedge clk) begin deassign my_reg;
 end endmodule
