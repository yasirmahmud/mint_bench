module curve_starc05_2_10_1_4b_20260111_225135_161432_w32456_attempt11 (
  input wire [2:0] data_in,
  output wire      flag_out
);

  // STARC05-2.10.1.4b violation: Signal compared with value containing z
  assign flag_out = (data_in === 3'b10z);

endmodule
