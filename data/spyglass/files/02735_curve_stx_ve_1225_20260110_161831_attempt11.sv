module curve_stx_ve_1225_20260110_161831_attempt11 (
  integer my_port
);
  // STX_VE_1225: Non-net variable 'my_port' cannot be an inout port
  // Explanation: 'integer' is a non-net variable type. When 'my_port' is declared
  // in the port list without an explicit direction (input/output/inout),
  // it defaults to an 'inout' port in Verilog-2001. The rule highlights
  // that a non-net variable cannot function as an inout port.
endmodule
