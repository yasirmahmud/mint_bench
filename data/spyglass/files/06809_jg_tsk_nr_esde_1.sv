module setup_edge_data_violation (
  input clk,
  input data_in
);

  specify
    specparam T_SETUP = 100;
    $setup(posedge data_in, posedge clk, T_SETUP);
  endspecify

endmodule
