module W224_ex1(input [1:0] a, input [1:0] b, output reg c);
 always @(*) begin if (a + b) c = 1'b1;
 else c = 1'b0;
 end endmodule
