module uninitialized_reset_ex2 (input clk, input rst, input data_in, output reg q_out);
 reg uninitialized_signal;
 always @(posedge clk or posedge rst) begin if (rst) begin q_out <= uninitialized_signal;
 end else begin q_out <= data_in;
 end end endmodule
