module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt7 (
  input [3:0] data_vector,
  output reg out_flag
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector)'.
  // Placing '!data_vector' directly in an 'if' condition, which expects a boolean expression,
  // attempts to satisfy the tool that logical negation is intended, potentially
  // suppressing the STARC05-2.1.4.5 rule (suggesting bit-wise operator).
  always @(*) begin
    if (!data_vector) begin
      out_flag = 1'b1;
    end else begin
      out_flag = 1'b0;
    end
  end

endmodule
