module curve_synth_5035_20260111_201723_485593_w36056_attempt10 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    // Default assignment to ensure 'out' is always driven and avoid latches
    out = 1'b0;

    case (sel)
      // The first occurrence of 2'b00
      2'b00: out = 1'b1;
      2'b01: out = 1'b0;
      2'b10: out = 1'b1;
      // This second occurrence of 2'b00 is a duplicate case item,
      // which is expected to trigger SYNTH_5035.
      // SpyGlass is expected to report: "Case 2'b00 has already been covered. Now ignoring it"
      2'b00: out = 1'b0;
      // Default case to cover 2'b11 and any X/Z states on 'sel',
      // ensuring 'out' is fully driven and no latches are inferred.
      default: out = 1'b0;
    endcase
  end

endmodule
