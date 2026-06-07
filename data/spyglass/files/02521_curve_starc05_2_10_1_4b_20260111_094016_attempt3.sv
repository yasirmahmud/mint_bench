module curve_starc05_2_10_1_4b_20260111_094016_attempt3 (
  input  wire [1:0]  data_in,
  output wire        has_z_comparison
);

  // STARC05-2.10.1.4b: Signal compared with value containing x or z
  // This 'assign' statement uses 'data_in' and drives 'has_z_comparison' (an output),
  // fulfilling the requirement to avoid unused signals. The comparison of 'data_in'
  // with '2'b1z' directly triggers the target rule.
  assign has_z_comparison = (data_in === 2'b1z); 

endmodule
