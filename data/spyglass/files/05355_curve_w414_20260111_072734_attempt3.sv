module curve_w414_20260111_072734_attempt3 (
  input a,
  input b,
  output reg result_q,
  output reg result_comb
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    result_q <= a ^ b;     // This non-blocking assignment in a combinational block triggers W414
    result_comb = a | b;   // Blocking assignment in a combinational block is acceptable
  end

endmodule
