module latch_w450l_ex2 (input [1:0] enable_bus, input data_in, output reg data_out);
 always @* begin if (enable_bus) data_out = data_in;
 end endmodule
