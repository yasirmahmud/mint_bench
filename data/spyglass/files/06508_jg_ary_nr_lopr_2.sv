module test_logical_not_multibit (
  input [2:0] data_in,
  output      data_out
);

assign data_out = !data_in; // Logical NOT applied to a multi-bit operand

endmodule
