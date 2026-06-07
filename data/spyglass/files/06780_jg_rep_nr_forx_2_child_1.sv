module rep_nr_forx_ex2 (
  output logic [3:0] result
);

  logic [1:0] data_bus = 2'bx; // Explicitly initialize to 'x' to maintain the behavior of 'result' being all 'x'

  // Replicate a specific 'x' bit from the explicitly initialized 'x' vector
  assign result = {4{data_bus[0]}};

endmodule
