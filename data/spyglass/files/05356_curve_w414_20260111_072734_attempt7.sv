module curve_w414_20260111_072734_attempt7 (
  input wire a_in,
  input wire b_in,
  input wire c_in,
  output reg o_out_nb,
  output reg o_out_b
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    o_out_nb <= a_in & b_in; // This non-blocking assignment in always @* triggers W414
    o_out_b = a_in | c_in;   // This blocking assignment is valid in always @*
  end

endmodule
