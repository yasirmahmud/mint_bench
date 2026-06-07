module CheckAsyncHold_ML_ex2(input clk, input rst_n, input enable1, input enable2, output reg data_out);
 always @(posedge clk or negedge rst_n or enable1) begin if (!rst_n) data_out <= 1'b0;
 else if (enable1) data_out <= 1'b1;
 else if (enable2) data_out <= data_out;
 end endmodule
