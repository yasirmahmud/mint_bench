module InvalidEdgeSignalUsage_ML_ex1 (input clk, input data_in, output reg data_out);
 always @(posedge clk) begin data_out = clk;
 end endmodule
