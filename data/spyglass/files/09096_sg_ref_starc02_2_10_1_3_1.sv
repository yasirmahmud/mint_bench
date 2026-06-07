module star_c02_2_10_1_3_ex1(input in_a, output reg out_q);
 always @(in_a) begin if (in_a == 1'bx) out_q = 1'b1;
 else out_q = 1'b0;
 end endmodule
