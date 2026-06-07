module top_module;
  // STX_VE_1232: Declaring an array of an undefined interface type
  // 'my_undefined_interface_t' is an unknown type, triggering the violation.
  my_undefined_interface_t interface_instance_array[2];

  // No other logic to avoid additional violations.

endmodule
