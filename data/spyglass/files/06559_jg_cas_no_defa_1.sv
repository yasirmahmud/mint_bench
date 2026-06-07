module wide_case_no_default_1 (
  input [31:0] selector,
  output reg out_val
);

always @(*) begin
  case (selector)
    32'h00000001: out_val = 1'b0;
    32'h00000002: out_val = 1'b1;
    // No default statement
  endcase
end

endmodule
