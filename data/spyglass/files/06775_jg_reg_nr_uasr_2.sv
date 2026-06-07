module test_reg_unassigned_read_2 (
  input wire in_data,
  output reg out_data
);

  reg another_unassigned_reg; // Declared but never assigned

  assign out_data = another_unassigned_reg; // Read here, but never assigned

endmodule
