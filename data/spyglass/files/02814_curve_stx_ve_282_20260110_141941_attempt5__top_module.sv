module top_module (
  input top_signal_in,
  output top_signal_out1,
  output top_signal_out2
);

  // Intentional STX_VE_282 violations:
  // The instance connections '.input_port_name_mismatch' and '.output_port_name_mismatch'
  // do not correspond to the actual port names 'sub_input_a' and 'sub_output_b' defined in 'sub_module'.
  // This should trigger two STX_VE_282 violations.
  sub_module u_sub_instance (
    .input_port_name_mismatch(top_signal_in),
    .output_port_name_mismatch(top_signal_out1)
  );

  // Assign top_signal_out2 to avoid an unused output warning
  assign top_signal_out2 = top_signal_in;

endmodule
