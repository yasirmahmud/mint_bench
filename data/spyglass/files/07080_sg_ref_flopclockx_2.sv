module flop_clock_x_ex2(input data_in, output reg q_out);
 wire undriven_clk;
 always @(posedge undriven_clk) begin q_out <= data_in;
 end endmodule
