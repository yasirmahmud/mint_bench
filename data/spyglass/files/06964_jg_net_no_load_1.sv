module net_no_load_example1 (
  input wire in_a,
  output wire out_b
);

  wire unused_net;

  assign unused_net = in_a; // 'unused_net' is driven but not loaded

  assign out_b = 1'b0; // Dummy output to make module complete

endmodule
