module latch_reset_ex2 (input enable, input rst_n, input data_in, output reg q1, output reg q2);
 always @(enable or rst_n or data_in) begin if (enable) begin if (rst_n) q1 <= 1'b0;
 else q1 <= data_in;
 end end always @(enable or rst_n or data_in) begin if (enable) begin if (~rst_n) q2 <= 1'b0;
 else q2 <= data_in;
 end end endmodule
