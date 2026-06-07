module curve_synth_5284_20260111_220510_406590_w15680_attempt12 (
  output wire out_signal
);

  // SYNTH_5284: Non synthesizable construct : floating point type constant
  // Declaring a parameter of type 'real' and initializing it with a floating-point literal
  // is considered non-synthesizable by synthesis tools, even though allowed by Verilog-2001.
  // This triggers SYNTH_5284 for the floating-point constant value itself.

  // Occurrence 1: The floating-point constant '3.14159' used for a 'real' parameter.
  parameter real PI_VAL = 3.14159;

  // Occurrence 2: The floating-point constant '2.71828' used for another 'real' parameter.
  parameter real E_VAL = 2.71828;

  // The comparison of parameters (which are fixed at elaboration) resolves to a constant
  // and is synthesizable. It is included to ensure the parameters are 'used' and avoid
  // other potential warnings about unused parameters.
  assign out_signal = (PI_VAL > E_VAL) ? 1'b1 : 1'b0;

endmodule
