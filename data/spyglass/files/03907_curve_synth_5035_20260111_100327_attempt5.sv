module curve_synth_5035_20260111_100327_attempt5 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00: out = 1'b0; // First occurrence of 2'b00
      2'b01: out = 1'b1;
      2'b10: out = 1'b0;
      2'b00: out = 1'b1; // Duplicate case item, should trigger SYNTH_5035
      default: out = 1'b0;
    endcase
  end

endmodule
