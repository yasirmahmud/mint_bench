module TopModule (
  input wire primary_in_a,
  input wire primary_in_b,
  output wire final_output
);
  wire internal_connection;

  // WRN_33: Module instance name not specified
  LeafModule (
    .input_a(primary_in_a),
    .input_b(primary_in_b),
    .output_sum(internal_connection)
  );

  assign final_output = internal_connection;

endmodule
