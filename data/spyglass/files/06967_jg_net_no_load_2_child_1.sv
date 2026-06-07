module net_no_load_example2 (
  input wire clk,
  input wire reset,
  input wire data_in,
  output wire data_out
);

  // The 'unused_reg' and its associated logic have been removed
  // as they were driven but never read, causing a NET_NO_LOAD violation.
  // This change preserves the functional behavior as the register's state
  // did not affect any observable output of the module.

  assign data_out = 1'b0; // Dummy output to make module complete

endmodule
