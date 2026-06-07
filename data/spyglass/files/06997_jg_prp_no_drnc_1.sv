module undriven_signal_in_property_1 (
  input clk,
  input rst
);

  logic data_valid; // This signal will be undriven

  property p_data_valid_check;
    @(posedge clk) (data_valid == 1'b1);
  endproperty

  assert property (p_data_valid_check);

endmodule
