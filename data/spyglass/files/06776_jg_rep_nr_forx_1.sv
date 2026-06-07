module rep_nr_forx_ex1 (
  output logic [7:0] out_vec
);

  logic uninitialized_bit; // This will be 'x' at time 0

  // Replicate the 'x' value
  assign out_vec = {8{uninitialized_bit}};

endmodule
