module STARC_2_3_2_4_ex1(input clk, output reg out_q);
 always @(posedge clk) begin reg [7:0] my_var;
 my_var = 8'd5;
 out_q <= 1'b0;
 end endmodule
