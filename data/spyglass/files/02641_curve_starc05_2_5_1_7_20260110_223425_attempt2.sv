module curve_starc05_2_5_1_7_20260110_223425_attempt2 (
  input wire ctrl_in,
  input wire data_in_val,
  output wire z_out
);

  // Assign a tri-state value to the output 'z_out'
  assign z_out = ctrl_in ? data_in_val : 1'bz;

  // Use the tri-state output 'z_out' in a conditional expression,
  // triggering the STARC05-2.5.1.7 violation.
  // The 'if' block is intentionally empty to avoid creating latches
  // or other unintended rule violations.
  always @* begin
    if (z_out) begin // STARC05-2.5.1.7 violation
      // No assignments here
    end
  end

endmodule
