module case_reuse_example2 (
  input wire clk,
  input wire data_in,
  output wire data_out
);

  sub_module DATA_IN (
    .in_port(data_in),
    .out_port(data_out)
  ); // Violates NAM_NR_REPU with 'data_in'

endmodule
