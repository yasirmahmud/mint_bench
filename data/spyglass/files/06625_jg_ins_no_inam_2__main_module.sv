module main_module (
  input wire data_in_a,
  input wire data_in_b,
  output wire result_out
);
  // Violation: Instantiation without an instance name
  sub_module (
    .in_a(data_in_a),
    .in_b(data_in_b),
    .out_c(result_out)
  );
endmodule
