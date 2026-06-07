module latch_enable_x_ex1 (input data_in, output reg data_out);
 wire enable_x = 1'bx;
 always @* begin if (enable_x) data_out = data_in;
 end endmodule
