module curve_stx_ve_1232_20260111_184210_334415_w47100_attempt7;
  // STX_VE_1232: 'my_channel_if' is an unknown type used in a declaration.
  // SpyGlass interprets this as an attempt to declare an interface array
  // where the interface type 'my_channel_if' is not defined.
  my_channel_if channel_array[5];
endmodule
