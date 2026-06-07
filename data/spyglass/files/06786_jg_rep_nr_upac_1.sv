module rep_unpacked_array_violation_1 (
  output logic [7:0] data_out [0:1]
);

  // Violation: Replication assigned to an unpacked array
  assign data_out = {2{8'hAA}};

endmodule
