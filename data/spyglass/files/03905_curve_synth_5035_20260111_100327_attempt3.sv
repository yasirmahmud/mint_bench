module curve_synth_5035_20260111_100327_attempt3 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      2'b10: out = 1'b0;
      2'b11: out = 1'b1;
      2'b00: out = 1'b0; // SYNTH_5035 violation: Case 2'b00 has already been covered
    endcase
  end

endmodule
