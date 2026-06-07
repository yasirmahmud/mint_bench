module complex_for_ex2(input clk, input in_bit, output reg out_bit);
 reg [7:0] my_vector;
 integer i;
 always @(posedge clk) begin for (i = 0; i < 7; i = i + 1) begin out_bit <= my_vector[i];
 my_vector[i+1] <= in_bit;
 end end endmodule
