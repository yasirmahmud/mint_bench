module curve_synth_12604_20260112_003253_093006_w47152_attempt16 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    out = 1'b0; // Default assignment to avoid latches

    casex (sel)
      3'b0xx: out = 1'b1; // Covers 3'b000, 3'b001, 3'b010, 3'b011
      3'b100: out = 1'b0;
      3'b001: out = 1'b0; // This specific label (3'b001) is already covered by 3'b0xx, triggering SYNTH_12604 (1st violation)
      3'b1x1: out = 1'b1; // Covers 3'b101, 3'b111
      3'b111: out = 1'b0; // This specific label (3'b111) is already covered by 3'b1x1, triggering SYNTH_12604 (2nd violation)
      // Other combinations like 3'b010, 3'b011 are also covered by 3'b0xx and 3'b101 by 3'b1x1. No new violations for these.
      // The assignment 'out = 1'b0;' at the beginning of the always block handles cases not explicitly listed, preventing latches.
    endcase
  end

endmodule
