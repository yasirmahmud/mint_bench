module top_module_ex1 (
  output wire [29:0] combined_data_out // Output to collect all results and avoid W528
);

  // Declare six wires with LSB:MSB ordering (e.g., index 0 is MSB, 4 is LSB)
  wire [0:4] conn_net_0;
  wire [0:4] conn_net_1;
  wire [0:4] conn_net_2;
  wire [0:4] conn_net_3;
  wire [0:4] conn_net_4;
  wire [0:4] conn_net_5;

  // Instantiate my_sub_block 6 times.
  // The 'data_out' port in 'my_sub_block' is declared as [4:0] (MSB:LSB).
  // The connecting nets 'conn_net_X' are declared as [0:4] (LSB:MSB).
  // When the 'data_out' port (entire bus [4:0]) is connected to 'conn_net_X' (entire bus [0:4]),
  // Verilog connects by index. This results in:
  //   my_sub_block.data_out[0] (LSB of port) <= conn_net_X[0] (MSB of net)
  //   ...
  //   my_sub_block.data_out[4] (MSB of port) <= conn_net_X[4] (LSB of net)
  // This constitutes a reversed bus connection in terms of logical bit ordering (MSB/LSB), triggering W156 for each instance.

  my_sub_block inst_0 (
    .data_out(conn_net_0) // W156 violation for 'data_out'
  );

  my_sub_block inst_1 (
    .data_out(conn_net_1) // W156 violation for 'data_out'
  );

  my_sub_block inst_2 (
    .data_out(conn_net_2) // W156 violation for 'data_out'
  );

  my_sub_block inst_3 (
    .data_out(conn_net_3) // W156 violation for 'data_out'
  );

  my_sub_block inst_4 (
    .data_out(conn_net_4) // W156 violation for 'data_out'
  );

  my_sub_block inst_5 (
    .data_out(conn_net_5) // W156 violation for 'data_out'
  );

  // Concatenate all outputs to ensure they are used, preventing W528 or similar unused signal warnings.
  assign combined_data_out = {conn_net_5, conn_net_4, conn_net_3, conn_net_2, conn_net_1, conn_net_0};

endmodule
