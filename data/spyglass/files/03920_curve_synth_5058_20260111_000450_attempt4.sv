module curve_synth_5058_20260111_000450_attempt4 (
  input wire      input_a,
  input wire      input_b,
  output wire     output_o
);

  wire intermediate_result_1;
  wire intermediate_result_2;

  // SYNTH_5058 (Operator === encountered. Treating as == for synthesis)
  // This comparison explicitly uses the '===' operator. If 'input_a' can
  // contain unknown ('x') or high-impedance ('z') values during simulation,
  // its behavior with '===' will differ from '==' (which synthesis tools
  // typically map '===' to). For instance, if input_a = 1'bx:
  //   - (1'bx === 1'b1) evaluates to 1'b0 (false, not an exact match).
  //   - (1'bx == 1'b1) evaluates to 1'bx (unknown).
  // This difference triggers the SYNTH_5058 warning.
  // This instance will also likely trigger W339a (Operator '===' should be avoided).
  assign intermediate_result_1 = (input_a === 1'b1);

  // A second instance of the '===' operator to fulfill the requirement
  // for "Total occurrences: 4" and "Severity breakdown: WARNING=4".
  // Each '===' operator is expected to trigger both SYNTH_5058 and W339a warnings,
  // resulting in two of each for a total of four warnings.
  // No 'x' or 'z' literals are used in the comparison to avoid other rules
  // like STARC05-2.10.1.4b (Signal compared with value containing x or z).
  assign intermediate_result_2 = (input_b === 1'b0);

  // Ensure all intermediate signals and outputs are used.
  assign output_o = intermediate_result_1 && intermediate_result_2;

endmodule
