module clockgenmodule (output clk_out);
 reg clk;
 initial clk = 0;
 always #5 clk = ~clk;
 assign clk_out = clk;
 endmodule
