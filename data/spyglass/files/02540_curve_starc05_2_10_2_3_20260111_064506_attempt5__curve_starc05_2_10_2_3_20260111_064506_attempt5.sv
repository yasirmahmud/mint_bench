module curve_starc05_2_10_2_3_20260111_064506_attempt5 (
  input wire [3:0] data_vector,
  output wire       dummy_out
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector)'
  // This example attempts to trigger ONLY the target rule by connecting the logical negation
  // of a multi-bit vector directly to a 1-bit input port of a sub-module.
  // The sub-module's port 'one_bit_in' is explicitly declared as 1-bit wide.
  // This explicit 1-bit context for the port connection is intended to strongly indicate
  // that the expression must resolve to a single bit. Replacing '!data_vector'
  // with a bit-wise operator '~data_vector' would result in a multi-bit value being connected
  // to a 1-bit port, which Verilog would truncate. This makes the suggestion by STARC05-2.1.4.5
  // (to use a bit-wise operator) semantically less appropriate or potentially misleading.
  // The goal is that this distinct usage within a port connection might suppress STARC05-2.1.4.5,
  // which often triggers alongside STARC05-2.10.2.3 in simpler assignment or if conditions.

  // Instantiate the sub-module and connect the logical negation of the vector
  sub_module i_sub_module (
    .one_bit_in ( !data_vector ) // Violation point: Logical negation on a multi-bit vector
  );

  // Assign a value to dummy_out to prevent an unused output warning for the top module
  assign dummy_out = 1'b0;

endmodule
