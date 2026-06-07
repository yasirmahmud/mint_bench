module curve_starc05_2_10_1_4a_20260111_224910_173048_w38092_attempt11 (
  input wire [1:0] data_port,
  output wire      is_bit_z
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This comparison directly triggers the violation.
  assign is_bit_z = (data_port[1] === 1'bz);

endmodule
