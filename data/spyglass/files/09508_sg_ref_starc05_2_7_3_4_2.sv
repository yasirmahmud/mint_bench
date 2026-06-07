module nested_if_ex2 (input a, input b, output reg out);
 always @(*) begin if (a) begin if (b) begin out = 1'b1;
 end end else begin out = 1'b0;
 end end endmodule
