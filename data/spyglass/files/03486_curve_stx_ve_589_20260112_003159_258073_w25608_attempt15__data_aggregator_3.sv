// Third declaration of 'data_aggregator'.
// This re-declaration triggers the second STX_VE_589 violation.
// It will also reference the initial declaration at line 7.
module data_aggregator (
  output wire aggregated_data_valid_o,
  output wire aggregated_data_out_o
);

  assign aggregated_data_valid_o = 1'b1;
  assign aggregated_data_out_o = 1'b0;

endmodule
