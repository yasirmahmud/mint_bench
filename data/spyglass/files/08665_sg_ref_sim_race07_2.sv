module sim_race07_ex2 (input clk_in, input d, output reg q);
 reg delayed_clk;
 always @(posedge clk_in) begin delayed_clk <= clk_in;
 end always @(posedge delayed_clk) begin q <= d;
 end endmodule
