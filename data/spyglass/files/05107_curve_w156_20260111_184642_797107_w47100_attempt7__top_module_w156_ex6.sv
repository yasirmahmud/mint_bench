module top_module_w156_ex6 ();

  wire [5:0] my_data_bus;
  wire [5:0] result_data;

  // Drive my_data_bus to avoid unused signal warning
  assign my_data_bus = 6'b101010;

  // Instantiate the sub-module with a reversed bus connection
  sub_module_w156_ex6 inst_sub (
    .data_port(my_data_bus), // W156 violation here: [5:0] connected to [0:5]
    .out_data(result_data)   // Connect output to avoid unused signal warning
  );

  // Use result_data to avoid unused signal warning and to avoid 'initial' block only for display
  // In a real design, this would connect to further logic
  wire unused_sink = result_data[0];

endmodule
