module rep_nr_forx_ex2 (
  output logic [3:0] result
);

  logic [1:0] data_bus; // Uninitialized, so data_bus[0] and data_bus[1] are 'x'

  // Replicate a specific 'x' bit from the uninitialized vector
  assign result = {4{data_bus[0]}};

endmodule
