module curve_starc05_2_10_1_4a_20260111_082442_attempt5 (
  input wire my_input_signal,
  output wire my_output_flag
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This assignment performs an X/Z-sensitive comparison of 'my_input_signal' with '1'bz'.
  // This is the most direct way to trigger STARC05-2.10.1.4a.
  assign my_output_flag = (my_input_signal === 1'bz);

endmodule
