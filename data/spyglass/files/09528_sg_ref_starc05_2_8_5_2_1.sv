module STARC05_2_8_5_2_ex1;
 reg out;
 always @* begin case (1'b1) 1'b0: out = 1'b0;
 1'b1: out = 1'b1;
 endcase end endmodule
