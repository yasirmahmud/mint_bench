module curve_stx_ve_1225_20260111_235143_206283_w47152_attempt22 (
  input integer my_int_port
);
  // This module demonstrates STX_VE_1225: Non-net variable 'my_int_port' cannot be an inout port.
  // In Verilog-2001, a port declared without 'input', 'output', or 'inout' is implicitly 'inout'.
  // 'integer' is a variable type, not a net type, making this declaration illegal for an inout port.
  // 
  // Fix: Explicitly declare the port as 'input' to resolve the STX_VE_1225 violation.
endmodule
