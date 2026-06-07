module star_2_3_1_2b_ex1(input clk, input rst, input d, output reg q);
 wire temp_w;
 assign temp_w = d;
 initial begin #10 assign q = temp_w;
 #20 deassign q;
 end endmodule
