module curve_synth_12604_20260111_175443_586439_w37940_attempt8 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    // Default assignment to ensure 'out' is always driven and avoid latches.
    out = 1'b0;

    unique case (sel)
      3'b000: out = 1'b0;
      3'b001: out = 1'b1; // First occurrence of label 3'b001
      3'b010: out = 1'b0;
      3'b011: out = 1'b1;
      3'b100: out = 1'b0;
      3'b001: out = 1'b0; // Duplicate occurrence of label 3'b001 - Triggers SYNTH_12604
      default: out = 1'b0;
    endcase
  end

endmodule
