module PartialConstantAssign_ex1 (input a, output reg b);
 always @(*) begin if (a) b = 1'b1;
 end endmodule
