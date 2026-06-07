module latch_w422l_ex2 (input clk1, input clk2, input data_in, output reg data_out);
 always @ (clk1 or clk2 or data_in) begin if (clk1 || clk2) begin data_out = data_in;
 end end endmodule
