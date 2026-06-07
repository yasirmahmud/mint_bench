module curve_starc05_1_2_1_2_20260111_225758_685376_w32456_attempt12 (
  input s_bar_in, // Active-low set input
  input r_bar_in, // Active-low reset input
  output q_out,
  output qn_out
);

  // Declaring q_internal_reg as a reg to infer a latch
  reg q_internal_reg;

  // Replacing the cross-coupled NAND gates with a behavioral always block
  // to resolve 'CombLoop' and 'STARC05-1.2.1.2' violations.
  // This explicitly describes the active-low RS latch functionality.
  always @(*) begin
    if (s_bar_in == 1'b0) begin // Active-low set condition (S_bar is low)
      q_internal_reg = 1'b1;
    end else if (r_bar_in == 1'b0) begin // Active-low reset condition (R_bar is low)
      q_internal_reg = 1'b0;
    end
    // If s_bar_in = 1 and r_bar_in = 1, the latch holds its current state.
    // If both s_bar_in = 0 and r_bar_in = 0, the 'set' condition takes precedence,
    // resolving the ambiguity in a synthesizable manner (q_internal_reg becomes 1'b1).
  end

  // Expose the Q and QN outputs of the latch
  assign q_out = q_internal_reg;
  assign qn_out = ~q_internal_reg; // qn_out is the complement of q_out

endmodule
