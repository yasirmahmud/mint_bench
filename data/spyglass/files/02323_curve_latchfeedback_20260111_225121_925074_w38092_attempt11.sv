module curve_latchfeedback_20260111_225121_925074_w38092_attempt11 (
  input enable_i,
  input [2:0] data_in_i,
  output [2:0] data_out_o
);

  reg [2:0] latch_reg;

  // This always block infers a latch for 'latch_reg'.
  // When 'enable_i' is high, 'latch_reg' updates based on its current value and 'data_in_i'.
  // When 'enable_i' is low, 'latch_reg' holds its previous value.
  always @(enable_i or data_in_i or latch_reg) begin
    if (enable_i) begin
      // The output 'latch_reg' is fed back into its own input computation (latch_reg = data_in_i & latch_reg).
      // This self-referential assignment within a latch creates a feedback path,
      // triggering the 'LatchFeedback' violation due to a potential race condition.
      latch_reg = data_in_i & latch_reg;
    end
    // else, latch_reg retains its value, inferring a latch.
  end

  assign data_out_o = latch_reg;

endmodule
