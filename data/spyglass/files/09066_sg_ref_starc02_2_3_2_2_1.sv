module starc02_2_3_2_2_ex1(input clk, input a, output reg q_b, output reg q_nb);
 always @(posedge clk) begin q_nb <= a;
 q_b = a;
 end endmodule
