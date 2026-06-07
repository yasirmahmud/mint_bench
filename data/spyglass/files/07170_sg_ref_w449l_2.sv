module latch_w449l_ex2 (input data_in, input enable_in, output reg data_out);
 always @(data_in or enable_in) begin if (~enable_in) data_out = data_in;
 end endmodule
