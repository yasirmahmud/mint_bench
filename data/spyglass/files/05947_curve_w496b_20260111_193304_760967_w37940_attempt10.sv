module curve_w496b_20260111_193304_760967_w37940_attempt10 (
  input [1:0]  sel_in,
  output reg   data_out
);

  always @(*) begin
    data_out = 1'b0; // Default assignment to prevent latches

    case (sel_in)
      2'b00: data_out = 1'b0;
      2'b01: data_out = 1'b1;
      // Target Rule: W496b
      // Rule description: "Case comparison of expression: "2'b1?" to tristate value: '1?' is treated as false in synthesis"
      // This line uses a '?' (don't care/tristate wildcard) in a case item, which directly triggers W496b.
      2'b1?: data_out = 1'b0;
      default: data_out = 1'b0;
    endcase
  end

endmodule
