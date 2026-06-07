module badimplicitSM1_ex2 (input clk, input rst_n, input data_in, input enable, output reg data_out);
 always @(posedge clk or negedge rst_n) begin if (enable) begin data_out <= data_in;
 end else if (!rst_n) begin data_out <= 1'b0;
 end else begin data_out <= data_out;
 end end endmodule
