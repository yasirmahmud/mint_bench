module curve_synth_12605_20260112_012253_124304_w6680_attempt19 (
  input [3:0] sel,
  output reg out_val
);

  always @(*) begin
    // Assign a default value to 'out_val' to prevent an unintended latch
    // for cases not covered by the 'priority case' statement.
    // This ensures no latch violation, but the 'priority case' itself remains incomplete.
    out_val = 1'b0;

    // SYNTH_12605 violation: Priority case statement is incomplete.
    // Only two conditions are covered for a 4-bit selector, out of 16 possible states.
    // No 'default' case is provided within the 'priority case' block.
    priority case (sel)
      4'b0001: out_val = 1'b1;
      4'b1010: out_val = 1'b0;
      // Conditions for other 14 states are intentionally left uncovered.
    endcase
  end

endmodule
