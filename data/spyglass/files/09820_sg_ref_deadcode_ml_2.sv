module deadcode_ml_ex2 (input a, output reg b);
 always @(*) begin b = 1'b0;
 if (1'b0) begin b = a;
 end end endmodule
