module EventControlInRHS_ex1(input clk, input data_in, output reg data_out);
 always @(data_in) begin data_out = @(posedge clk) data_in;
 end endmodule
