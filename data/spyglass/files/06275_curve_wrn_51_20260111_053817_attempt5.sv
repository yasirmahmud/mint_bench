module curve_wrn_51_20260111_053817_attempt5 (
  input [3:0] in_a,
  input [2:0] in_b,
  output reg [7:0] out_c
);

  // WRN_51: Concatenation with unsized number (0). Some simulators might not support this.
  // The literal '0' is unsized and used in concatenation, triggering the violation.
  always @(*) begin
    out_c = {in_a, 0, in_b};
  end

endmodule
