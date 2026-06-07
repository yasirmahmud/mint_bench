module curve_w496b_20260111_193304_760967_w37940_attempt8 (
  input [1:0]  selector,
  output reg   out_reg
);

  always @(*) begin
    out_reg = 1'b0; // Default assignment to prevent latches

    case (selector)
      2'b00: out_reg = 1'b0;
      2'b01: out_reg = 1'b1;
      2'b1?: out_reg = 1'b0; // Target Rule: W496b
      default: out_reg = 1'b0;
    endcase
  end

endmodule
