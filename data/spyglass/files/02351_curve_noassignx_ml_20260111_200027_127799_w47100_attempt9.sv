module curve_noassignx_ml_20260111_200027_127799_w47100_attempt9 (
  output wire [3:0] data_out
);

  // This register is initialized with an 'x' value at declaration.
  // This direct initialization of a register with 'x' on its RHS
  // explicitly triggers the NoAssignX-ML rule (reason: Initialization to 'x').
  reg [3:0] initial_val_reg = 4'bxxxx;

  // The output is continuously driven by the initialized register.
  // This assignment itself does not contain 'x' on its RHS directly.
  assign data_out = initial_val_reg;

endmodule
