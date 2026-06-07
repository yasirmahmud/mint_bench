module curve_synth_5035_20260111_100327_attempt2 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00, 2'b01, 2'b00: out = 1'b0; // "2'b00" is duplicated within this single case item
      2'b10: out = 1'b1;
      2'b11: out = 1'b0;
    endcase
  end

endmodule
