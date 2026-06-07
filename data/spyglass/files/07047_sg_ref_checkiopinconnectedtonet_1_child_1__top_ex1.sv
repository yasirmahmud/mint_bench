module top_ex1;
  wire top_in_a;
  wire top_out_z;

  // Drive the input to resolve UndrivenInTerm-ML and W287a
  assign top_in_a = 1'b0; // Example: drive with a constant value

  my_cell u_inst (
    .in_a (top_in_a),
    .out_z (top_out_z)
  );
endmodule
