module my_module_ex2 (input clk, output reg out_reg);
 reg some_reg;
 always @(posedge clk or (some_reg = 1'b0)) begin out_reg <= some_reg;
 end endmodule
