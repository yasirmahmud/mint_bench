module latch_enable_const_ex1 (input data_in, output reg data_out);
 wire enable_const = 1'b1;
 wire reset_n = 1'b1;
 always @(enable_const or data_in or reset_n) begin if (!reset_n) begin data_out = 1'b0;
 end else if (enable_const) begin data_out = data_in;
 end end endmodule
