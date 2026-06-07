module coverage_pragma_ex2;
 reg a;
 // synthesis coverage off always @(*) begin a = 1'b0; end // synthesis coverage off always @(*) begin a = 1'b1; end endmodule
