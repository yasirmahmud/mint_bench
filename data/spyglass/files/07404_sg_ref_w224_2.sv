module w224_ex2(input [1:0] data_in, output reg data_out);
 always @(*) begin data_out = (data_in) ? 1'b1 : 1'b0;
 end endmodule
