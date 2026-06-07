module curve_starc05_2_10_2_3_20260111_191000_037997_w47100_attempt10 (
  input       clk,
  input       rst_n,
  input [1:0] data_in_vec,
  output reg  output_val
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_in_vec)'.
  // This example attempts to trigger only STARC05-2.10.2.3 by placing the logical negation
  // within an always block's conditional statement, where the intent is to check if the vector is all zeros.
  // The '!' operator on a multi-bit vector resolves to a single bit (1 if all bits are 0, else 0).
  // If a bit-wise NOT (~) were used, it would produce a multi-bit result which would then
  // require a reduction operator (e.g., |~) to be a valid condition, altering the functional intent
  // (checking if vector is all zeros vs. checking if vector contains any zero).

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      output_val <= 1'b0;
    end else begin
      if (!data_in_vec) begin // <-- Target violation: STARC05-2.10.2.3
        output_val <= 1'b1;
      end else begin
        output_val <= 1'b0;
      end
    end
  end

endmodule
