module curve_synth_12604_20260110_152704_attempt4 (
  input [3:0] sel,
  output reg out
);

  always @(*) begin
    unique case (sel)
      4'b0000: out = 1'b0;
      4'b0001: out = 1'b1; // First occurrence of this label
      4'b0010: out = 1'b0;
      4'b1010: out = 1'b1; // First occurrence of this label
      4'b0011: out = 1'b0;
      4'b0001: out = 1'b0; // This is a duplicate label, triggering SYNTH_12604 (first violation)
      4'b0100: out = 1'b1;
      4'b1010: out = 1'b0; // This is another duplicate label, triggering SYNTH_12604 (second violation)
      default: out = 1'b0;
    endcase
  end

endmodule
