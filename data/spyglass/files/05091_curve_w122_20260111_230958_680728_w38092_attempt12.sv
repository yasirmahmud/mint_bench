module curve_w122_20260111_230958_680728_w38092_attempt12 (
  input wire [3:0] i_data_a,
  input wire [3:0] i_data_b,
  output reg [3:0] o_result
);

  // W122 violation: The signal 'i_data_b' is read on the RHS of the assignment
  // inside the always block, but it is not included in the sensitivity list.
  // This will cause the combinatorial logic driving 'o_result' to only re-evaluate
  // when 'i_data_a' changes, potentially leading to a functional mismatch
  // or an unintended latch-like behavior for 'i_data_b'.
  always @(i_data_a) begin
    o_result <= i_data_a + i_data_b; // 'i_data_b' is read here but not in the sensitivity list
  end

endmodule
