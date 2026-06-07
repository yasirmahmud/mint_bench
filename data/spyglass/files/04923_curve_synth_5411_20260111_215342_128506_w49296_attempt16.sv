module curve_synth_5411_20260111_215342_128506_w49296_attempt16 (
  input wire [7:0] data_in,
  output wire [0:0] data_out
);

  // Declare an explicit zero-width wire. In Verilog, a range [msb:lsb]
  // where msb < lsb results in a zero-width vector.
  wire [-1:0] zero_replication_result;

  // SYNTH_5411: This assignment directly triggers the violation.
  // A zero-replication multiplier is used in a concatenation expression.
  // The left-hand side is also zero-width, preventing WRN_24 (width mismatch).
  assign zero_replication_result = {0{data_in}};

  // This ensures that 'data_out', 'data_in', and 'zero_replication_result' are all used.
  // 'zero_replication_result' (0-width) is concatenated with a 1-bit constant.
  // The result '{1'b0, zero_replication_result}' is 1-bit wide (effectively 1'b0).
  // Selecting bit [0] gives 1'b0, which is assigned to 'data_out'.
  // This avoids WRN_47 (undriven output) for data_out and W528 (unused signal).
  assign data_out = {1'b0, zero_replication_result}[0];

endmodule
