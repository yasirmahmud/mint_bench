module test_logical_not_multibit_distinct_assign (
  input wire [7:0] data_vector_in,
  output reg        is_zero_flag
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector_in)'.
  // This rule fires when a logical NOT operator '!' is applied to a multi-bit vector.
  // Verilog treats this as a reduction operation, returning 1'b1 if all bits are 0,
  // and 1'b0 otherwise. This behavior might be unintentional or unclear.
  always @(*) begin
    is_zero_flag = !data_vector_in;
  end

endmodule
