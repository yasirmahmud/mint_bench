module curve_w287b_20260111_194449_406742_w53504_attempt7 (
  input  top_in,
  output top_out
);
  wire internal_connection_y;

  // Instantiate sub-module, leaving one output port unconnected
  data_processor u_processor_inst (
    .a_in    (top_in),
    .out_x   (), // W287b violation: Instance output port 'out_x' is not connected
    .out_y   (internal_connection_y) // Connected to avoid unused signal warning
  );

  // Use the connected output to avoid unused signal warnings
  assign top_out = internal_connection_y;

endmodule
