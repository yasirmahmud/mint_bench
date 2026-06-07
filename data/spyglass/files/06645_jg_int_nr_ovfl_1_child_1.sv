module int_overflow_pos_example();
  // WRN_58: Numeric value exceeds 32-bit capacity.
  //   - Changed 'integer' to 'localparam longint' to allow the value 2147483648
  //     to be stored without overflow. 'longint' is 64-bit signed.
  //
  // SYNTH_5143: Initial block is ignored for synthesis.
  //   - Removed the 'initial' block by initializing 'my_int' directly as a localparam.
  //     Localparams are compile-time constants and don't require an initial block.
  //
  // W528: Variable 'my_int' set but not read.
  //   - By making 'my_int' a 'localparam', it is a constant, not a variable.
  //     Unread warnings typically apply to variables. Constants do not trigger this warning.
  //     This maintains the core behavior of associating the value 2147483648 with 'my_int'.
  localparam longint my_int = 2147483648;

endmodule
