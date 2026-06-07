module STARC05_2_2_3_2_ex2 (input wire clk, input wire rst, input wire data_in, input wire enable, output reg q);
 always @(posedge clk or posedge rst) begin q <= 1'b0;
 if (!rst) begin if (enable) begin q <= data_in;
 end end end endmodule
