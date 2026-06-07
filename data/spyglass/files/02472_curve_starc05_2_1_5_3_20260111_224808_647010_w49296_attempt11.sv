module curve_starc05_2_1_5_3_20260111_224808_647010_w49296_attempt11 (
  input wire [1:0] non_scalar_condition,
  input wire       control_input,
  output reg       result_out
);

  // STARC05-2.1.5.3: Conditional expression 'non_scalar_condition' does not evaluate to a scalar.
  // The 'if' statement expects a 1-bit scalar condition, but 'non_scalar_condition' is 2-bit.
  always @(*) begin
    if (non_scalar_condition) begin // This is the violation point
      result_out = control_input;
    end else begin
      result_out = 1'b0;
    end
  end

endmodule
