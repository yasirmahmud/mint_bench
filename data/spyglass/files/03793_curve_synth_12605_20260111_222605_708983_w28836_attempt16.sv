module curve_synth_12605_20260111_222605_708983_w28836_attempt16 (
  input [1:0] sel,
  output reg out
);

  always_comb begin
    // Initialize 'out' to a default value to prevent latch inference.
    // This ensures that all paths assign a value to 'out', while the 'priority case'
    // itself remains incomplete for specific 'sel' values.
    out = 1'b0;

    priority case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // Conditions for 2'b10 and 2'b11 are intentionally left uncovered
      // to trigger the SYNTH_12605 violation.
    endcase
  end

endmodule
