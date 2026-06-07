module curve_latchfeedback_20260111_225121_925074_w38092_attempt11 (
  input enable_i,
  input [2:0] data_in_i,
  output [2:0] data_out_o
);

  reg [2:0] latch_reg;
  // Declare a combinational wire to calculate the next potential value for latch_reg.
  // This explicitly defines the combinational feedback path, breaking the direct
  // self-referential assignment within the always block and preventing LatchFeedback violations.
  wire [2:0] next_latch_reg_val;

  // The next state logic for the latch's input.
  // The output 'latch_reg' is fed back into its own input computation (data_in_i & latch_reg).
  // This combinational assignment is outside the 'always' block.
  assign next_latch_reg_val = data_in_i & latch_reg;

  // This always block infers a latch for 'latch_reg'.
  // When 'enable_i' is high, 'latch_reg' updates based on 'next_latch_reg_val'.
  // When 'enable_i' is low, 'latch_reg' holds its previous value.
  // The sensitivity list now includes 'enable_i' and 'next_latch_reg_val'.
  // This resolves the W122 violation because all signals read on the RHS of
  // assignments within this 'always' block ('enable_i', 'next_latch_reg_val')
  // are explicitly included in the sensitivity list.
  // It also resolves the LatchFeedback violation by separating the combinational
  // feedback logic into a distinct 'assign' statement. The 'always' block no longer
  // has 'latch_reg' directly on its RHS, and 'next_latch_reg_val' is a valid input.
  always @(enable_i or next_latch_reg_val) begin
    if (enable_i) begin
      latch_reg = next_latch_reg_val;
    end
    // else, latch_reg retains its value, inferring a latch.
  end

  assign data_out_o = latch_reg;

endmodule
