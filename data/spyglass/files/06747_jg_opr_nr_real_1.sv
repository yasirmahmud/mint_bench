module real_compare_example1();
  real r_a = 3.14;
  real r_b = 2.71;
  logic result;

  always_comb begin
    // Lint warning: Real operand (r_a) is used in logical comparison.
    if (r_a > r_b) begin
      result = 1;
    end else begin
      result = 0;
    end
  end
endmodule
