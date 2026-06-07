module curve_starc05_2_1_4_5_20260111_225723_179578_w49296_attempt12 (
  input [1:0] data_val_a,
  input [1:0] data_val_b,
  output reg  final_result
);

  // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands 'data_val_a' and 'data_val_b'
  // This should trigger the violation.
  always @* begin
    final_result = data_val_a && data_val_b;
  end

endmodule
