module curve_synth_12605_20260112_012253_124304_w6680_attempt20 (
  input [2:0] sel,
  output reg out_data
);

  always @(*) begin
    // Default assignment to 'out_data' to prevent unintended latch inference
    // for cases not explicitly covered by the 'priority case' statement.
    // This ensures that only the SYNTH_12605 violation is triggered.
    out_data = 1'b0;

    // SYNTH_12605 violation: This priority case statement is incomplete.
    // A 3-bit selector ('sel') has 2^3 = 8 possible states.
    // Only one specific condition (3'b001) is covered here.
    // The remaining 7 conditions are intentionally left uncovered, and
    // no 'default' case is provided within the 'priority case' block.
    priority case (sel)
      3'b001: out_data = 1'b1;
      // Conditions for 3'b000, 3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111
      // are intentionally left uncovered to trigger SYNTH_12605.
    endcase
  end

endmodule
