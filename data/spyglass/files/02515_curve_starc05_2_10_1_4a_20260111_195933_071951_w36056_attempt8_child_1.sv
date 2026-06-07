module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt8 (
  input wire  data_in_bit,
  output wire is_z_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // Original intent was to check for a 'z' value. However, 'z' states are not synthesizable
  // for internal logic on an 'input wire'. In a synthesizable design, an input wire is
  // expected to be driven to a '0' or '1'. Thus, the comparison (data_in_bit === 1'bz)
  // would always evaluate to '0' in synthesized hardware. To resolve all linting violations
  // related to 'z' comparisons and the '===' operator, while preserving the synthesizable
  // functional behavior, the output flag is hardwired to '0'.
  assign is_z_flag = 1'b0;

endmodule
