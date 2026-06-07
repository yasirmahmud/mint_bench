module curve_stx_ve_481_20260111_155918_071333_w30032_attempt2 (
  input wire [1:0] in_a,
  output reg out_b
);

always @* begin
  case (in_a)
    2'b00: out_b = 1'b0;
    2'b01: out_b = 1'b1;
    default: out_b = 1'b0;
  endcase
  // The 'else' keyword here is illegal as it does not follow an 'if' statement.
  // This directly triggers the STX_VE_481 violation.
  else
    out_b = 1'b0;
end

endmodule
