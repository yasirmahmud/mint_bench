module genvar_cond_ex1;
 reg a, b;
 genvar i;
 generate for (i = 0; i < 1; i = i + 1) begin : g always @(*) if (i == 0) a = b;
 end endgenerate endmodule
