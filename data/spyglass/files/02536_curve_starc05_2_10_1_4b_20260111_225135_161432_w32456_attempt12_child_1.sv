module curve_starc05_2_10_1_4b_20260111_225135_161432_w32456_attempt12 (
  input wire [1:0] data_in
);

  // The initial block, the comparison with 'x', and the use of '==='
  // are non-synthesizable constructs and cause the reported violations.
  // To resolve these, the initial block which serves simulation-only purposes
  // is removed, as it does not contribute to the synthesizable functional behavior
  // of the hardware design.

endmodule
