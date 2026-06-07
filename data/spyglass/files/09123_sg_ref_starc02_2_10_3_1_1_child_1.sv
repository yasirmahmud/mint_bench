module STARC02_2_10_3_1_ex1(input [3:0] a, input [4:0] b, output reg out);
 always @(*) begin
  if ({{5{1'b0}}, a} == (a * b)) begin
   out = 1'b1;
  end else begin
   out = 1'b0;
  end
 end
endmodule
