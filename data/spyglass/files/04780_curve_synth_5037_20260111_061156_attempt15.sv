module curve_synth_5037_20260111_061156_attempt15 (
  input wire in_cond,
  output reg out_val
);

  // Declare a 2-bit wire for the case selector.
  // This selector is deliberately constrained to only two values: 2'b00 (decimal 0) or 2'b01 (decimal 1).
  wire [1:0] selector;
  assign selector = in_cond ? 2'b00 : 2'b01;

  always @(*) begin
    // Initialize output to a default value to avoid unintentional latches for
    // any unassigned paths, including implicit cases for X/Z values in 'selector'.
    out_val = 1'bx;

    // The 'case' expression 'selector' is 2 bits wide.
    // Due to the 'assign' statement above, 'selector' can only ever be 2'b00 or 2'b01.
    case (selector)
      // Reachable cases based on the 'in_cond' input:
      2'b00: out_val = 1'b0; // Reached when in_cond is 1'b1
      2'b01: out_val = 1'b1; // Reached when in_cond is 1'b0

      // TARGET SYNTH_5037 VIOLATION (exactly one occurrence):
      // The branch condition '2'b10' (which is decimal 2) is impossible to meet.
      // The 'selector' wire can never take the value 2'b10 because its assignment
      // strictly limits its possible values to 2'b00 or 2'b01.
      2'b10: out_val = 1'b0;

      // The 'default' statement covers all remaining possible values for a 2-bit selector
      // not explicitly listed (i.e., 2'b11, which is decimal 3) and any X/Z states.
      // By covering 2'b11 with a 'default' rather than an explicit '2'b11:' case item,
      // we ensure that only the '2'b10:' branch triggers the SYNTH_5037 violation.
      default: out_val = 1'b1;
    endcase
  end

endmodule
