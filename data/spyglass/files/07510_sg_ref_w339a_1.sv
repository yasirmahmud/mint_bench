module w339a_ex1(input [1:0] a, input [1:0] b, output reg out);
 always @(*) begin if (a === b) out = 1'b1;
 else out = 1'b0;
 end endmodule
