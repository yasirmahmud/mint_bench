module undriven_inout_port (
  input wire enable,
  inout wire io_bus
);
  // 'io_bus' is declared as an inout port but is never driven from within this module.
  // This will trigger OTP_NR_UDRV.

  // Fix for W240: Input 'enable' declared but not read.
  // By assigning 'enable' to an internal dummy wire, we ensure it is read within the module.
  wire dummy_enable_reader;
  assign dummy_enable_reader = enable;

endmodule
