module curve_w414_20260111_224419_579858_w15680_attempt17 (
  input [2:0] in_a,
  input [2:0] in_b,
  output reg [2:0] out_nonblocking,
  output reg [5:0] out_blocking
);

  // W414: Non-blocking assignment should not be used in a combinational block
  always @* begin
    // This non-blocking assignment in an always @* block triggers W414
    out_nonblocking <= in_a | in_b;

    // This blocking assignment is appropriate for combinational logic in an always @* block
    out_blocking = {in_a, in_b};
  end

endmodule
