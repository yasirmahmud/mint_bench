module curve_synth_5035_20260111_201723_485593_w36056_attempt7 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    out = 1'b0; // Default assignment to ensure 'out' is always driven and avoid latches

    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // This case item (2'd0) represents the same numeric value (0) as 2'b00.
      // SpyGlass is expected to flag SYNTH_5035 here, as the value 0 is already covered.
      2'd0:  out = 1'b0;
      2'b10: out = 1'b1;
      default: out = 1'b0; // Covers 2'b11 and any X/Z states on 'sel'
    endcase
  end

endmodule
