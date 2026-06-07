module curve_synth_12604_20260112_003253_093006_w47152_attempt15 (
  input [2:0] sel,
  output reg out
);

  always @(*) begin
    out = 1'b0; // Default assignment to avoid latches for unlisted or 'x' cases

    casex (sel)
      3'b00x: out = 1'b1; // Covers 3'b000, 3'b001
      3'b010: out = 1'b0;
      3'b1x0: out = 1'b1; // Covers 3'b100, 3'b110
      3'b001: out = 1'b0; // This case label (3'b001) is already covered by 3'b00x, triggering SYNTH_12604
      3'b101: out = 1'b1;
      3'b111: out = 1'b0;
      // Other combinations like 3'b011 will implicitly take the default 'out = 1'b0' and will not trigger latches.
    endcasex
  end

endmodule
