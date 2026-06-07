module curve_w414_20260111_072734_attempt10 (
  input wire in1,
  input wire in2,
  input wire in3,
  input wire in4,
  output reg out1,
  output reg out2
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    out1 <= in1 & in2; // This non-blocking assignment in a combinational block should trigger W414
    out2 = in3 | in4;
  end

endmodule
