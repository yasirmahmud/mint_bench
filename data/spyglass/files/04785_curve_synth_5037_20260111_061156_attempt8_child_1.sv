module curve_synth_5037_20260111_061156_attempt8 (
  input wire [2:0] sel_in, // 3-bit input signal
  output reg out_val      // Output based on the case statement
);

  // Declare a wire to hold the constrained version of 'sel_in'.
  // This wire will effectively limit the range of values that can be passed
  // to the case statement selector.
  // If sel_in is 0, 1, 2, 3, or 4, 'constrained_sel' takes that value.
  // If sel_in is 5, 6, or 7, 'constrained_sel' is forced to 3'd4.
  // Thus, 'constrained_sel' can only ever take values 0, 1, 2, 3, or 4.
  wire [2:0] constrained_sel;
  assign constrained_sel = (sel_in > 3'd4) ? 3'd4 : sel_in;

  always @(*) begin
    // Removed default assignment 'out_val = 1'bx;' as it's not needed to prevent
    // latch inference since all reachable paths (0-4 for constrained_sel) are
    // explicitly covered in the case statement, resolving the NoAssignX-ML violation.

    case (constrained_sel) // 'constrained_sel' is a 3-bit signal (0 to 4 effectively)
      3'd0: out_val = 1'b0; // Reachable: constrained_sel is 0
      3'd1: out_val = 1'b1; // Reachable: constrained_sel is 1
      3'd2: out_val = 1'b0; // Reachable: constrained_sel is 2
      3'd3: out_val = 1'b1; // Reachable: constrained_sel is 3
      3'd4: out_val = 1'b0; // Reachable: constrained_sel is 4 (includes original sel_in values 5, 6, 7)

      // TARGET SYNTH_5037 VIOLATION:
      // This case label '3'd5' is 3 bits wide, matching the selector 'constrained_sel'.
      // However, due to the logic in the 'assign' statement for 'constrained_sel',
      // 'constrained_sel' can never attain the value 3'd5 (decimal 5).
      // Therefore, this branch condition is impossible to meet, making the statement unreachable.
      // This should trigger exactly one SYNTH_5037 violation and no W263 (width mismatch).
      3'd5: out_val = 1'b1; // Unreachable statement

      // No 'default' case is strictly necessary here to prevent latches,
      // as all possible values of 'constrained_sel' (0, 1, 2, 3, 4) are explicitly covered.
    endcase
  end

endmodule
