module curve_starc05_2_5_1_7_20260111_182048_695986_w36056_attempt9 (
  input wire i_enable,
  input wire i_data,
  output wire o_tri_state_bit,
  output reg o_logic_out
);

  // Drive 'o_tri_state_bit' as a tri-state output, resolving to 'z' when not enabled.
  // This signal is a single bit.
  assign o_tri_state_bit = i_enable ? i_data : 1'bz;

  // The single-bit tri-state output 'o_tri_state_bit' is used in the conditional expression of an if statement.
  // This directly triggers the STARC05-2.5.1.7 violation.
  always @(*) begin
    if (o_tri_state_bit) begin // STARC05-2.5.1.7 violation
      o_logic_out = 1'b1;
    end else begin
      o_logic_out = 1'b0;
    end
  end

endmodule
