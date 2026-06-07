module curve_w289_20260110_205726_attempt4 (
  output reg out_a,
  output reg out_b
);

  // Declare and initialize two real variables.
  // Verilog-2001 allows direct initialization of real variables.
  real real_var_a = 1.23;
  real real_var_b = 4.56;

  always @(*) begin
    // Default assignments to prevent latches
    out_a = 0;
    out_b = 0;

    // W289 violation 1: Comparing real_var_a with '=='
    // Rule: A real_var operand: 'real_var_a' should not be used with logical comparison operator '=='
    if (real_var_a == 1.23) begin
      out_a = 1;
    end

    // W289 violation 2: Comparing real_var_b with '=='
    // Rule: A real_var operand: 'real_var_b' should not be used with logical comparison operator '=='
    if (real_var_b == 4.56) begin
      out_b = 1;
    end
  end

endmodule
