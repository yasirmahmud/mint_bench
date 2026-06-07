module curve_w414_20260111_224419_579858_w15680_attempt16 (
  input [3:0] data_in_a,
  input [3:0] data_in_b,
  output reg [3:0] result_nb,
  output reg [3:0] result_b
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    // This non-blocking assignment in a combinational block triggers W414
    result_nb <= data_in_a + data_in_b;

    // This blocking assignment is acceptable in a combinational block
    result_b = data_in_a ^ data_in_b;
  end

endmodule
