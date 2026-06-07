module curve_w337_20260111_194833_042150_w7792_attempt8 (
  output reg out_val
);

  // Declare a wire that is explicitly assigned an 'x' value.
  // This ensures the 'case' expression itself contains an 'x'.
  // Verilog-2001 allows for explicit 'x' values in expressions.
  wire [1:0] x_expr;
  assign x_expr = 2'b1x;

  always @* begin
    // Default assignment to prevent latch inference
    out_val = 1'b0;

    // W337 violation: Using 'x' in a regular 'case' item is illegal.
    // In Verilog-2001's 'case' statement (not casex/casez), 'x' in a case item
    // implies an exact bit-by-bit match, but 'x' is not '0' or '1'.
    // By making the case expression 'x_expr = 2'b1x', the comparison
    // (x_expr == 2'b1x) becomes TRUE when x_expr itself is 2'b1x.
    // This strategy is intended to prevent the SYNTH_5034 warning
    // ("Comparison with don't care or tristate will be always false")
    // which usually accompanies W337 when the case expression is assumed
    // to be 0/1. Here, the comparison is not always false.
    case (x_expr)
      2'b1x: out_val = 1'b1;
      // Include a default to ensure full coverage and avoid latches
      default: out_val = 1'b0;
    endcase
  end

endmodule
