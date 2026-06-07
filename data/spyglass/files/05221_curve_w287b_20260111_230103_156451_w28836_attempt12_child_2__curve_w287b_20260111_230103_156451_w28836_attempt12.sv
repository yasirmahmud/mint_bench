module curve_w287b_20260111_230103_156451_w28836_attempt12 (
  input wire [7:0] i_data_a,
  input wire [7:0] i_data_b,
  output wire [7:0] o_result
);

  wire [7:0] w_sub_result;

  // Instantiation of a sub-module
  processing_unit u_processor (
    .in_a    (i_data_a),
    .in_b    (i_data_b),
    .out_sum (w_sub_result)
    // .out_flag is left unconnected as its value is not used, resolving W528 violation
  );

  assign o_result = w_sub_result;

endmodule
