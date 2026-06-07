module curve_synth_5035_20260111_201723_485593_w36056_attempt9 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    out = 1'b0; // Default assignment to ensure 'out' is always driven and avoid latches

    case (sel)
      // The value '2'b00' is listed twice within the same case item's selection list.
      // This pattern successfully triggered SYNTH_5035 in previous attempts without other violations.
      // SpyGlass is expected to report: "Case 2'b00 has already been covered. Now ignoring it"
      2'b00, 2'b01, 2'b00: out = 1'b1;
      2'b10: out = 1'b0;
      default: out = 1'b0; // Covers 2'b11 and any X/Z states on 'sel'
    endcase
  end

endmodule
