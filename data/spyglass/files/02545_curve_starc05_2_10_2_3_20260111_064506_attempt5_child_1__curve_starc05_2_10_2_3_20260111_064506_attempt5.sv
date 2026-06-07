module curve_starc05_2_10_2_3_20260111_064506_attempt5 (
  input wire [3:0] data_vector,
  output wire       dummy_out
);

  // STARC05-2.10.2.3 & STARC05-2.1.4.5: Logical negation used on a vector '(!data_vector)'
  // The expression '!(|data_vector)' is functionally equivalent to '!data_vector'
  // for multi-bit vectors, evaluating to 1'b1 if all bits are 0, and 1'b0 (or 1'bX)
  // otherwise. This change resolves the linting violations by first performing
  // an OR-reduction to get a single bit, then applying logical negation.

  // Instantiate the sub-module and connect the logical negation of the vector
  sub_module i_sub_module (
    .one_bit_in ( !(|data_vector) ) // FIX: Replaced !data_vector with !(|data_vector) to resolve STARC05-2.10.2.3 and STARC05-2.1.4.5
  );

  // Assign a value to dummy_out to prevent an unused output warning for the top module
  assign dummy_out = 1'b0;

endmodule
