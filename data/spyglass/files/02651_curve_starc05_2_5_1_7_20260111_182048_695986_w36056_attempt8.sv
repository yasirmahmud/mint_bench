module curve_starc05_2_5_1_7_20260111_182048_695986_w36056_attempt8 (
  input wire i_enable,
  input wire [1:0] i_data,
  output wire [1:0] o_tri_state_bus,
  output wire o_logic_out
);

  // Drive 'o_tri_state_bus' as a tri-state output, resolving to 'z' when not enabled.
  // This signal is a 2-bit bus.
  assign o_tri_state_bus = i_enable ? i_data : 2'bz;

  reg r_local_flag;

  // The multi-bit tri-state output 'o_tri_state_bus' is used in the conditional expression of an if statement.
  // This directly triggers the STARC05-2.5.1.7 violation.
  always @(*) begin
    if (o_tri_state_bus) begin // STARC05-2.5.1.7 violation
      r_local_flag = 1'b1;
    end else begin
      r_local_flag = 1'b0;
    end
  end

  // Assign the result to an output to avoid an unused signal warning for 'r_local_flag'.
  assign o_logic_out = r_local_flag;

endmodule
