module starc05_1_1_1_7_ex1 (input clk, input my_reset, input data_in, output reg q);
 always @(posedge clk) begin q <= data_in;
 if (my_reset == 1'b0) begin q <= 1'b0;
 end end endmodule
