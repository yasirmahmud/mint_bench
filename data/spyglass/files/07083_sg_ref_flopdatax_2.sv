module flop_data_x_ex2 (input clk, output reg q);
 wire undriven_data;
 always @(posedge clk) begin q <= undriven_data;
 end endmodule
