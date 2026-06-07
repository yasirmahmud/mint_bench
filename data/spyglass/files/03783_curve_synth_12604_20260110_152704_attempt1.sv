module curve_synth_12604_20260110_152704_attempt1 (
  input [1:0] sel,
  output reg out
);

  always @(*) begin
    unique case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // The following line creates a duplicate label, triggering SYNTH_12604.
      // Since 2'b00 appears twice, it results in two violations.
      2'b00: out = 1'b0;
      default: out = 1'b0;
    endcase
  end

endmodule
