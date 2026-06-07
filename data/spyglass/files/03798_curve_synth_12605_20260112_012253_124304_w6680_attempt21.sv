module curve_synth_12605_20260112_012253_124304_w6680_attempt21 (
  input [3:0] sel,
  output reg out_data
);

  always @(*) begin
    // Default assignment to 'out_data' to prevent unintended latch inference
    // for cases not explicitly covered by the 'priority case' statement.
    // This ensures that only the SYNTH_12605 violation is triggered.
    out_data = 1'b0;

    // SYNTH_12605 violation: This priority case statement is incomplete.
    // A 4-bit selector ('sel') has 2^4 = 16 possible states.
    // Only two specific conditions (4'b0001, 4'b0010) are covered here.
    // The remaining 14 conditions are intentionally left uncovered, and
    // no 'default' case is provided within the 'priority case' block.
    priority case (sel)
      4'b0001: out_data = 1'b1;
      4'b0010: out_data = 1'b1;
      // Conditions for 4'b0000, 4'b0011, ..., 4'b1111 are intentionally left
      // uncovered to trigger SYNTH_12605.
    endcase
  end

endmodule
