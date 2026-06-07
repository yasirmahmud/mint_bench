module latch_w449l_ex1 (input enable_in, data_in, output reg q_out);
 always @(enable_in or data_in) begin if (~enable_in) q_out <= data_in;
 end endmodule
