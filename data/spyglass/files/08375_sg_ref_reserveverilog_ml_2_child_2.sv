module reserve_ml_ex2(input clk);
 wire some_wire;
 wire unused_clk_sink; // Added to resolve W240: Input 'clk' declared but not read.
 assign unused_clk_sink = clk;
 endmodule
