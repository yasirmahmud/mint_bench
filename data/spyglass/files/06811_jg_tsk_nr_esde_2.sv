module hold_edge_data_violation (
  input clk,
  input data_in
);

  specify
    specparam T_HOLD = 50;
    $hold(posedge clk, negedge data_in, T_HOLD);
  endspecify

endmodule
