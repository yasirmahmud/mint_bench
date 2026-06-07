module curve_latchfeedback_20260111_200604_968565_w36056_attempt10 (
  input wire enable,
  input wire [2:0] data_in,
  output reg [2:0] q_out
);

  reg [2:0] my_latch_reg;

  // This always block defines a level-sensitive latch.
  // A latch is inferred because 'my_latch_reg' is conditionally assigned
  // and not assigned in the 'else' branch, meaning it holds its value
  // when 'enable' is low.
  always @(enable or data_in or my_latch_reg) begin
    if (enable) begin
      // This line creates the feedback loop for the latch.
      // The next value of 'my_latch_reg' (LHS) depends on its current value (RHS)
      // combined with 'data_in'. This forms a combinational feedback path
      // directly affecting the data input of the latch, which should trigger
      // the 'LatchFeedback' violation.
      my_latch_reg = my_latch_reg + data_in;
    end
    // Implicitly holds its value when 'enable' is 0, inferring a latch.
  end

  // Assign the latch output to an external port to avoid unused signal warnings.
  assign q_out = my_latch_reg;

endmodule
