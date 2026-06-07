module curve_combloop_20260111_155329_327035_w30032_attempt3 (
  input i_data,
  output o_result
);

  // Declare internal wires for the combinational loop.
  // Using 1-bit wires to avoid width mismatch warnings.
  wire w_a;
  wire w_b;

  // These continuous assignments create a combinational loop:
  // w_a depends on w_b and i_data.
  // w_b depends on w_a.
  // This forms a cycle: w_a -> w_b -> w_a.
  // The input 'i_data' is included in the loop's expression to help prevent
  // 'UndrivenInTerm-ML' violations that might occur if the loop was entirely self-contained
  // without any external driving signal, as seen in previous attempts.
  assign w_a = i_data ^ w_b;
  assign w_b = w_a;

  // Connect one of the loop signals to the output to ensure it is used.
  assign o_result = w_a;

endmodule
