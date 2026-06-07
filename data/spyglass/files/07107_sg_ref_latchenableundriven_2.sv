module latch_undriven_ex2 (input data_in, input enable, output reg q);
 always @(data_in or enable) begin if (enable) begin q = data_in;
 end endmodule
