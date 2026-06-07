module rep_unpacked_array_violation_2 (
  input wire [3:0] in_val,
  output logic [3:0] my_vec [0:2]
);

  // Violation: Replication of 'in_val' assigned to an unpacked array 'my_vec'
  assign my_vec = {3{in_val}};

endmodule
