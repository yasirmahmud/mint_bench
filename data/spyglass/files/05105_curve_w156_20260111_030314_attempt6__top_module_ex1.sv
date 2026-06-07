module top_module_ex1 (
  output wire [23:0] all_data_out // Output to collect all results and avoid unused signal warnings
);

  // Declare six wires with LSB:MSB ordering (e.g., index 0 is MSB, 3 is LSB)
  wire [0:3] control_bus_0;
  wire [0:3] control_bus_1;
  wire [0:3] control_bus_2;
  wire [0:3] control_bus_3;
  wire [0:3] control_bus_4;
  wire [0:3] control_bus_5;

  // Declare outputs for sub-modules
  wire [3:0] sub_out_0;
  wire [3:0] sub_out_1;
  wire [3:0] sub_out_2;
  wire [3:0] sub_out_3;
  wire [3:0] sub_out_4;
  wire [3:0] sub_out_5;

  // Drive the LSB:MSB ordered wires to ensure they are used as inputs to sub_module
  assign control_bus_0 = 4'h1;
  assign control_bus_1 = 4'h2;
  assign control_bus_2 = 4'h4;
  assign control_bus_3 = 4'h8;
  assign control_bus_4 = 4'hA;
  assign control_bus_5 = 4'h5;

  // Instantiate sub_module 6 times.
  // The 'data_in' port in 'sub_module' is declared as [3:0] (MSB:LSB).
  // The connecting nets 'control_bus_X' are declared as [0:3] (LSB:MSB).
  // When the 'data_in' port (entire bus [3:0]) is connected to 'control_bus_X' (entire bus [0:3]),
  // Verilog connects by index. This results in:
  //   sub_module.data_in[0] (LSB of port) <= control_bus_X[0] (MSB of net)
  //   ...
  //   sub_module.data_in[3] (MSB of port) <= control_bus_X[3] (LSB of net)
  // This constitutes a reversed bus connection in terms of logical bit ordering (MSB/LSB), triggering W156 for each instance.

  sub_module inst_0 (
    .data_in(control_bus_0), // W156 violation for 'data_in'
    .data_out(sub_out_0)
  );

  sub_module inst_1 (
    .data_in(control_bus_1), // W156 violation for 'data_in'
    .data_out(sub_out_1)
  );

  sub_module inst_2 (
    .data_in(control_bus_2), // W156 violation for 'data_in'
    .data_out(sub_out_2)
  );

  sub_module inst_3 (
    .data_in(control_bus_3), // W156 violation for 'data_in'
    .data_out(sub_out_3)
  );

  sub_module inst_4 (
    .data_in(control_bus_4), // W156 violation for 'data_in'
    .data_out(sub_out_4)
  );

  sub_module inst_5 (
    .data_in(control_bus_5), // W156 violation for 'data_in'
    .data_out(sub_out_5)
  );

  // Concatenate all outputs to ensure they are used, preventing other warnings.
  assign all_data_out = {sub_out_5, sub_out_4, sub_out_3, sub_out_2, sub_out_1, sub_out_0};

endmodule
