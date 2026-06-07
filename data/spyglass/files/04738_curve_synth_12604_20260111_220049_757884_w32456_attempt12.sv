module curve_synth_12604_20260111_220049_757884_w32456_attempt12 (
  input [2:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      3'b000: out = 1'b0;
      3'b001: out = 1'b1; // First occurrence of label 3'b001
      3'b010: out = 1'b0;
      3'b011: out = 1'b1;
      3'b100: out = 1'b0;
      3'b101: out = 1'b1; // First occurrence of label 3'b101
      3'b001: out = 1'b0; // Duplicate occurrence of label 3'b001 - Triggers SYNTH_12604 (1st violation)
      3'b110: out = 1'b1;
      3'b101: out = 1'b0; // Duplicate occurrence of label 3'b101 - Triggers SYNTH_12604 (2nd violation)
      default: out = 1'b0; // Covers any remaining case (3'b111) to avoid latches.
    endcase
  end

endmodule
