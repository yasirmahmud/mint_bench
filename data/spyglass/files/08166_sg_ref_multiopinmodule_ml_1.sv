module MultiOpInModule_ML_ex1 (input [1:0] a, input [1:0] b, input [1:0] c, output reg [2:0] out);
 always @(*) begin out = 3'b0;
 if (a == b) begin out = a + c;
 end endmodule
