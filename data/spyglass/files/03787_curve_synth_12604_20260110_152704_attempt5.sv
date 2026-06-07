module curve_synth_12604_20260110_152704_attempt5 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    unique case (sel)
      3'b000: out = 1'b0;
      3'b001: out = 1'b1;
      3'b010: out = 1'b0;
      3'b001: out = 1'b0; // This is a duplicate label, triggering SYNTH_12604 (first violation)
      3'b011: out = 1'b1;
      3'b100: out = 1'b0;
      3'b000: out = 1'b1; // This is another duplicate label, triggering SYNTH_12604 (second violation)
      default: out = 1'b0;
    endcase
  end

endmodule
