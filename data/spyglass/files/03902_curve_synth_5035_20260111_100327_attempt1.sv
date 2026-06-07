module curve_synth_5035_20260111_100327_attempt1 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      2'b00: out = 1'b0; // This is the duplicate case item
      default: out = 1'b0;
    endcase
  end

endmodule
