module curve_starc05_2_10_2_3_20260111_064506_attempt3 (
  input [3:0] data_vector,
  input       enable,
  output reg  result
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector)'
  // This rule is triggered by applying the logical NOT operator '!' to a multi-bit vector.
  // This example places the logical negation within a conditional statement to emphasize its intended boolean context,
  // distinguishing it from a direct assignment where a bit-wise NOT (~) might sometimes be mistakenly assumed.
  always @(*) begin
    if (!data_vector && enable) begin 
      result = 1'b1;
    end else begin
      result = 1'b0;
    end
  end

endmodule
