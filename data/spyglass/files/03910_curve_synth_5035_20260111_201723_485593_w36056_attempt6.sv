module curve_synth_5035_20260111_201723_485593_w36056_attempt6 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      2'b10: out = 1'b0;
      2'b00: out = 1'b1; // SYNTH_5035: Case 2'b00 has already been covered.
      default: out = 1'b0;
    endcase
  end

endmodule
