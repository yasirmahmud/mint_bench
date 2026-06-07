module starc_2_10_1_4_ex1(input in_a, output reg out_q);
  always @(*) begin
    // The original comparison 'in_a == 1'bx' with standard equality (==)
    // always evaluates to 'x' (unknown) when an 'x' is involved. 
    // In an 'if' condition, an 'x' is treated as 'false'.
    // Therefore, the 'if' branch was never taken, and 'out_q' was effectively always '1'b0'
    // in both simulation and synthesis. This change preserves that behavior.
    out_q = 1'b0;
  end
endmodule
