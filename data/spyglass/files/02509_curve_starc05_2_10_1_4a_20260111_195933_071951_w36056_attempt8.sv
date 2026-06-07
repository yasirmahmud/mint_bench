module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt8 (
  input wire  data_in_bit,
  output wire is_z_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This comparison directly targets the rule by checking for a 'z' value.
  assign is_z_flag = (data_in_bit === 1'bz);

endmodule
