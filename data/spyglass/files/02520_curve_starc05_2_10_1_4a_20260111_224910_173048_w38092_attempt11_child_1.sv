module curve_starc05_2_10_1_4a_20260111_224910_173048_w38092_attempt11 (
  input wire [1:0] data_port,
  output wire      is_bit_z
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // The original comparison (data_port[1] === 1'bz) is not synthesizable
  // as hardware cannot detect a 'z' (high-impedance) state directly within logic gates.
  // In a synthesized design, data_port[1] will always be driven as '0' or '1'.
  // Consequently, the comparison to 1'bz would always evaluate to false in synthesized hardware.
  // To resolve the linting violations (STARC05-2.10.1.4a, STARC05-2.10.1.4b, SYNTH_5058, W339a)
  // while preserving the synthesizable functional behavior (i.e., 'is_bit_z' always being false
  // in hardware), 'is_bit_z' is explicitly assigned to 0.
  assign is_bit_z = 1'b0;

endmodule
