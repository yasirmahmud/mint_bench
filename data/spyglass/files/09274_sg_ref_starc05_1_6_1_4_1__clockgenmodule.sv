module clockgenmodule (output clk_out);
 reg clk_reg;
 assign clk_out = clk_reg;
 always #5 clk_reg = ~clk_reg;
 initial clk_reg = 0;
 endmodule
