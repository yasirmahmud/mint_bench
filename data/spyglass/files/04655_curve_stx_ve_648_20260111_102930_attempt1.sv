module STX_VE_648_example (
  input clk
);

  // This declaration triggers STX_VE_648 as 'data_out' is not in the module header's port list.
  output wire data_out;

  assign data_out = clk;

endmodule
