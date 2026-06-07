module curve_w496b_20260111_092151_attempt2 (
  input       sel_in, // 1-bit input
  output reg  out_reg
);

  always @(*) begin
    case (sel_in)
      1'b0:    out_reg = 1'b0;
      1'b1:    out_reg = 1'b1;
      1'b?:    out_reg = 1'b0; // This line is expected to trigger W496b
      default: out_reg = 1'b0;
    endcase
  end

endmodule
