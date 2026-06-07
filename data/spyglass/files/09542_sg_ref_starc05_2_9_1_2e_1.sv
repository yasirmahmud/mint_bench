module STARC05_2_9_1_2e_ex1 (input clk, output reg [3:0] out);
 integer i;
 always @(posedge clk) begin for (i = 0; i < 4; i = i + 1) begin out[i] <= i;
 end out[0] <= i;
 end endmodule
