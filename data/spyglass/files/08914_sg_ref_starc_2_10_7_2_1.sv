module STARC_2_10_7_2_ex1(input A, B, C, output reg Y);
 always @(*) begin if ((A + B) > C) Y = 1'b1;
 else if ((A + B) < C) Y = 1'b0;
 else Y = 1'bX;
 end endmodule
