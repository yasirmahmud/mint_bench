module invalid_edge_signal_usage_ex2 (input clk, output reg out_q);
 always @(posedge clk) begin out_q <= clk;
 end endmodule
