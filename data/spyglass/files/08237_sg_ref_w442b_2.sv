module W442b_ex2 (input clk, input rst_in, input data_in, output reg q);
 always @(posedge clk or posedge rst_in) begin if (rst_in == data_in) q <= 1'b0;
 else q <= data_in;
 end endmodule
