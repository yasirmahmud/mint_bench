module clockgenmodule (output reg clk_out);
 initial clk_out = 0;
 always #5 clk_out = ~clk_out;
 endmodule
