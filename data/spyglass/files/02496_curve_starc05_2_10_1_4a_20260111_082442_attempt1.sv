module curve_starc05_2_10_1_4a_20260111_082442_attempt1 (
  input wire data_in,
  output wire flag_z
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  assign flag_z = (data_in === 1'bz);

endmodule
