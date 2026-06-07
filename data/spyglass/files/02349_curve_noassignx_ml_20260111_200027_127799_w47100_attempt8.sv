module curve_noassignx_ml_20260111_200027_127799_w47100_attempt8 (
  input wire select_input,
  output wire [3:0] data_out
);

  // This assign statement assigns a value containing 'x' on its RHS
  // when select_input is high, triggering the NoAssignX-ML rule.
  assign data_out = select_input ? 4'b101x : 4'b0110;

endmodule
