module ClockSignalInSenseList_ex1 (input clk, input data_in, output reg data_out);
 always @(posedge clk or data_in) begin data_out <= data_in;
 end endmodule
