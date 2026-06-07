module curve_synth_5035_20260111_100327_attempt4 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00, 2'b01, 2'b01: out = 1'b0; // Duplicate '2'b01' in the same case item list
      2'b10: out = 1'b1;
      2'b11: out = 1'b0;
      default: out = 1'b0;
    endcase
  end

endmodule
