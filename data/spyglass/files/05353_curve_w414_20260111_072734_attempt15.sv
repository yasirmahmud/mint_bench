module curve_w414_20260111_072734_attempt15 (
  input wire in_data1,
  input wire in_data2,
  input wire in_data3,
  input wire in_data4,
  output reg out_result1,
  output reg out_result2
);

  // W414: Non-blocking assignment should not be used in a combinational block
  // This always @* block describes combinational logic.
  // Using a non-blocking assignment ('<=') for 'out_result1' here
  // triggers the W414 violation.
  always @* begin
    out_result1 <= in_data1 & in_data2; // This line triggers W414
    out_result2 = in_data3 | in_data4; // This is a correct blocking assignment for combinational logic
  end

endmodule
