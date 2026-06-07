module curve_combloop_20260111_155329_327035_w30032_attempt4 (
  input i_data,
  output o_result
);

  // Declare internal wires for the combinational loop.
  // Using 1-bit wires to avoid width mismatch warnings.
  wire w_a;
  wire w_b;
  wire w_c;

  // These continuous assignments create a combinational loop:
  // w_a depends on w_c and i_data.
  // w_b depends on w_a.
  // w_c depends on w_b.
  // This forms a cycle: w_a -> w_b -> w_c -> w_a.
  // The input 'i_data' is included in the loop's expression to help prevent
  // 'UndrivenInTerm-ML' violations that might occur if the loop was entirely self-contained
  // without any external driving signal.
  assign w_a = w_c ^ i_data;
  assign w_b = w_a;
  assign w_c = w_b;

  // Connect one of the loop signals to the output to ensure it is used.
  assign o_result = w_a;

endmodule
