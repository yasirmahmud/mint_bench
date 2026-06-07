module curve_w496b_20260111_225402_139681_w28836_attempt11 (
  input  [2:0] selector_in,
  output reg    output_data
);

  // This always block describes combinational logic.
  always @* begin
    // Using a 'case' statement with an input expression.
    case (selector_in)
      3'b000: output_data = 1'b0;
      3'b001: output_data = 1'b1;
      3'b010: output_data = 1'b0;
      // W496b: Case comparison of expression like '3'b01?' to a tristate value like '1?'
      // is treated as false in synthesis. The '?' is interpreted as a literal X or Z, 
      // rather than a wildcard 'don't care' for matching. This leads to a mismatch
      // between simulation and synthesis behavior.
      3'b01?: output_data = 1'b1; // This line is specifically designed to trigger W496b.
      3'b100: output_data = 1'b0;
      default: output_data = 1'b0; // Ensures all possible input combinations (including X/Z) are covered, preventing latches and SYNTH_5034.
    endcase
  end

endmodule
