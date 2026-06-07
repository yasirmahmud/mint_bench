module curve_starc05_1_2_1_2_20260111_225758_685376_w32456_attempt11 (
  input s_in,
  input r_in,
  output q_out,
  output qn_out
);

  // Internal register for the latch's Q output
  reg q_internal;
  // Internal wire for the latch's QN output
  wire qn_internal;

  // Inferred active-high RS latch logic.
  // This structure avoids primitive cell instantiation, thereby resolving STARC05-1.2.1.2.
  // The use of an 'always @*' block to infer a latch typically resolves the CombLoop violation,
  // as synthesis tools interpret this as a memory element rather than a combinational cycle.
  // For the historically "forbidden" S=1, R=1 state, this implementation prioritizes reset (Q=0, QN=1).
  // This is a common and synthesizable interpretation of an RS latch, preserving its core functional behavior.
  always @* begin
    if (r_in == 1'b1) begin      // Reset is active (high), priority reset
      q_internal = 1'b0;
    end else if (s_in == 1'b1) begin // Set is active (high)
      q_internal = 1'b1;
    end
    // If both s_in and r_in are 0, q_internal retains its value, correctly inferring a latch.
  end

  // QN output is the inverse of Q for all valid states.
  assign qn_internal = ~q_internal;

  // Expose the Q and QN outputs of the latch
  assign q_out = q_internal;
  assign qn_out = qn_internal;

endmodule
