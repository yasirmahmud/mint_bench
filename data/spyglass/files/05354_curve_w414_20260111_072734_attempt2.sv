module curve_w414_20260111_072734_attempt2 (
  input in1,
  input in2,
  output reg out_nb,
  output reg out_b
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    out_nb <= in1 & in2; // This non-blocking assignment in a combinational block triggers W414
    out_b = in1 | in2;   // Blocking assignment in a combinational block is fine
  end

endmodule
