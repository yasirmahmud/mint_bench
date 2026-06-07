module curve_w496b_20260111_092151_attempt1 (
  input [1:0] sel,
  output reg  out
);

  always @(*) begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      2'b1?: out = 1'b0; // Triggers W496b: Case comparison of expression "2'b1?" to tristate value '1?' is treated as false in synthesis
      default: out = 1'b0;
    endcase
  end

endmodule
