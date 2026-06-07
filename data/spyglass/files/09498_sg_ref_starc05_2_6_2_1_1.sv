module starc05_2_6_2_1_ex1 (input clk, input rst_n, input in1, input in2, output reg out1);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out1 <= 1'b0;
 end if (in1) begin out1 <= in2;
 end end endmodule
