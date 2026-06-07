module starc_2_1_1_1_ex1 (input a, b, output c, d);
 assign c = a & b;
 always @(*) begin d = a | b;
 end endmodule
