// Top module instantiating basic_processor with extra connections
module system_top (
  input wire sys_clk,
  input wire sys_reset,
  input wire [7:0] system_data_in,
  output wire [7:0] system_data_out
);

  wire [7:0] internal_data_bus;
  wire       dummy_signal_a;
  wire       dummy_signal_b;

  // This instantiation will trigger STX_VE_690 violations because
  // '.extra_control_signal' and '.debug_register' do not exist in 'basic_processor'.
  // This provides two occurrences of the rule as required by 'Total occurrences (from summary): 2'.
  basic_processor u_processor (
    .clk        (sys_clk),
    .reset      (sys_reset),
    .data_in    (system_data_in),
    .data_out   (internal_data_bus),
    .extra_control_signal (dummy_signal_a), // First extra connection
    .debug_register       (dummy_signal_b)  // Second extra connection
  );

  assign system_data_out = internal_data_bus;
  assign dummy_signal_a = 1'b0; // Assign to avoid unused signal warning
  assign dummy_signal_b = 1'b1; // Assign to avoid unused signal warning

endmodule
