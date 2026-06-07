// Second declaration of 'sensor_interface'.
// This re-declaration will trigger the first STX_VE_589 violation,
// referencing the initial declaration at line 3.
module sensor_interface (
  input wire config_i,
  output wire busy_o
);

  assign busy_o = config_i;

endmodule
