module net_no_load_example1 (
  input wire in_a,
  output wire out_b
);

  // wire unused_net; // Removed as it was unused

  // assign unused_net = in_a; // Removed as 'unused_net' was not loaded

  assign out_b = 1'b0; // Dummy output to make module complete

endmodule
