// Third declaration of 'sensor_interface'.
// This re-declaration will trigger the second STX_VE_589 violation,
// also referencing the initial declaration at line 3.
module sensor_interface (
  input wire cmd_valid_i,
  output wire cmd_ack_o
);

  assign cmd_ack_o = cmd_valid_i;

endmodule
