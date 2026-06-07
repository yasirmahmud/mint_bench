module curve_synth_5290_20260111_024903_attempt8 (
  input wire enable_condition,
  input real input_analog_value, // SYNTH_5290 violation: 'real' type used for an input port
  output wire output_digital_flag
);

  // Using a 'real' type input port directly in a synthesizable comparison
  // triggers SYNTH_5290. Hardware logic cannot directly process 'real' numbers.
  assign output_digital_flag = enable_condition && (input_analog_value > 10.5);

endmodule
