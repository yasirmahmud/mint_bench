module curve_starc05_2_1_4_5_20260111_225723_179578_w49296_attempt11 (
  input [1:0] condition_a,
  input [2:0] condition_b,
  output reg  result_flag
);

  // STARC05-2.1.4.5: Using logical AND (&&) with multi-bit operands 'condition_a' and 'condition_b'
  always @* begin
    result_flag = condition_a && condition_b;
  end

endmodule
