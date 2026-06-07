module curve_synth_5037_20260111_061156_attempt7 (
  input wire [1:0] sel_in, // A 2-bit input signal
  output reg out_val      // Output based on the case statement
);

  // 'sel_in' is a 2-bit signal, so its possible decimal values are 0, 1, 2, and 3.
  // In a 'case' statement, if a case item constant is wider than the case expression,
  // the case expression is implicitly zero-extended to match the width of the widest case item.

  always @(*) begin
    case (sel_in) // 'sel_in' is 2-bit (e.g., 2'b00, 2'b01, 2'b10, 2'b11)
      2'b00: out_val = 1'b0; // Reachable: sel_in is 0
      2'b01: out_val = 1'b1; // Reachable: sel_in is 1
      2'b10: out_val = 1'b0; // Reachable: sel_in is 2
      2'b11: out_val = 1'b1; // Reachable: sel_in is 3

      // TARGET: This case label '10' (decimal), which is 4'b1010 in binary if sized to 4 bits,
      // is unreachable. Since 'sel_in' is only 2 bits wide, its maximum value is 3 (2'b11).
      // When 'sel_in' is compared to '10', 'sel_in' is zero-extended (e.g., 2'b00 becomes 4'b0000,
      // 2'b11 becomes 4'b0011). None of these zero-extended 2-bit values can ever match 4'b1010.
      // This should trigger exactly one SYNTH_5037 violation.
      10: out_val = 1'b0; // Unreachable: 2-bit selector cannot be decimal 10

      // A default case ensures 'out_val' is always assigned, preventing latch inference.
      // The explicit cases 0-3 cover all possible 2-bit values for 'sel_in'.
      // However, the presence of the '10' case item potentially extends the comparison width
      // for the default, but the rule SYNTH_5037 specifically targets the numeric condition.
      default: out_val = 1'bx;
    endcase
  end

endmodule
