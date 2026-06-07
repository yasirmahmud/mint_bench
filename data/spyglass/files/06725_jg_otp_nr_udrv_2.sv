module undriven_inout_port (
  input wire enable,
  inout wire io_bus
);
  // 'io_bus' is declared as an inout port but is never driven from within this module.
  // This will trigger OTP_NR_UDRV.
endmodule
