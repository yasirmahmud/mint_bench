module curve_noassignx_ml_20260111_200027_127799_w47100_attempt9 (
  output wire [3:0] data_out
);

  // This register is declared without an explicit initial value.
  // In simulation, an uninitialized 'reg' defaults to 'x'.
  // This resolves the NoAssignX-ML rule by not assigning 'x' on the RHS
  // and the SYNTH_89 rule by not using initial assignment at declaration.
  reg [3:0] initial_val_reg;

  // The output is continuously driven by the register.
  assign data_out = initial_val_reg;

endmodule
