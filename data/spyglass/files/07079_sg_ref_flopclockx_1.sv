module FlopClockX_ex1 (input data_in, output reg data_out);
 wire clk_x;
 always @(posedge clk_x) begin data_out <= data_in;
 end endmodule
