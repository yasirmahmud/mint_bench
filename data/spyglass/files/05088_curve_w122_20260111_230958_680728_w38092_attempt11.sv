module curve_w122_20260111_230958_680728_w38092_attempt11 (
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  output reg [7:0] out_c
);

  // W122 violation: The signal 'in_b' is read on the RHS of an assignment
  // but is not included in the sensitivity list of the always block.
  // This will cause 'out_c' to behave like a latch, as it will only update
  // when 'in_a' changes, not when 'in_b' changes.
  always @(in_a) begin
    out_c <= in_a ^ in_b;
  end

endmodule
