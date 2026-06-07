module star_2_3_1_5a_ex1(input clk, output reg out);
 initial out = 0;
 always @(posedge clk) #1.5 out = ~out;
 endmodule
