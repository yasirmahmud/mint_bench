module curve_starc05_2_10_1_4a_20260111_082442_attempt1 (
  input wire data_in,
  output wire flag_z
);

  // The original comparison (data_in === 1'bz) is problematic for synthesis.
  // In synthesizable logic, an input wire 'data_in' is expected to be either '0' or '1',
  // not a high-impedance 'z'. Therefore, the comparison (data_in === 1'bz)
  // would always evaluate to false in synthesized hardware.
  // To preserve this synthesizable behavior and resolve all linting violations
  // related to '===', 'x', and 'z' comparisons, 'flag_z' is assigned a constant '0'.
  assign flag_z = 1'b0;

endmodule
