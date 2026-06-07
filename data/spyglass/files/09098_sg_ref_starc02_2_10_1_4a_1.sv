module star_c02_2_10_1_4a_ex1 (input a, output reg b);
 always @(*) begin if (a == 1'bx) b = 1;
 else b = 0;
 end endmodule
