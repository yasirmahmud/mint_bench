module curve_w496b_20260111_193304_760967_w37940_attempt6 (
  input [2:0] data_in,
  output reg result_out
);

always @(*) begin
  case (data_in)
    3'b000: result_out = 1'b0;
    3'b011: result_out = 1'b1;
    3'b1?0: result_out = 1'b0; // W496b: Case comparison of expression to tristate value treated as false in synthesis
    default: result_out = 1'b0;
  endcase
end

endmodule
