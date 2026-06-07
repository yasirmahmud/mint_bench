module curve_synth_12604_20260111_175443_586439_w37940_attempt10 (
  input [1:0] sel,
  output reg out
);

  always @(*) begin
    // Default assignment to ensure 'out' is always driven and avoid latches.
    out = 1'b0;

    unique case (sel)
      2'b00: out = 1'b1;
      2'b01: out = 1'b0; // First occurrence of label 2'b01
      2'b10: out = 1'b1;
      2'b01: out = 1'b1; // Duplicate occurrence of label 2'b01 - Triggers SYNTH_12604 (1st violation)
      2'b11: out = 1'b0;
      // All possible 2-bit 'sel' values are explicitly covered, so no default is strictly necessary to avoid latches.
    endcase
  end

endmodule
