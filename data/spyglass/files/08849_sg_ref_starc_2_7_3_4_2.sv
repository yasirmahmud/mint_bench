module nested_if_ex2 (input a, input b, output reg out_reg);
 always @(*) begin out_reg = 1'b0;
 if (a) begin if (b) begin out_reg = 1'b1;
 end end endmodule
