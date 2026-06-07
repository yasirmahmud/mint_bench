module multiple_bits_in_reset_ex2 (input clk, input [1:0] reset_vec, input data, output reg q);
 always @(posedge clk or posedge reset_vec) begin if (reset_vec) q <= 1'b0;
 else q <= data;
 end endmodule
