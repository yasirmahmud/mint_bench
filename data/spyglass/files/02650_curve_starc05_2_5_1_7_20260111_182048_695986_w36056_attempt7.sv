module curve_starc05_2_5_1_7_20260111_182048_695986_w36056_attempt7 (
  input wire in_data,
  input wire enable,
  output wire result_out,
  output wire tri_state_sig
);

  // Drive 'tri_state_sig' as a tri-state output, resolving to 'z' when not enabled.
  assign tri_state_sig = enable ? in_data : 1'bz;

  reg local_result;

  // The tri-state output 'tri_state_sig' is used in the conditional expression of an if statement.
  // This directly triggers the STARC05-2.5.1.7 violation.
  always @(*) begin
    if (tri_state_sig) begin // STARC05-2.5.1.7 violation
      local_result = 1'b1;
    end else begin
      local_result = 1'b0;
    end
  end

  // Assign the result to an output to avoid an unused signal warning for 'local_result'.
  assign result_out = local_result;

endmodule
