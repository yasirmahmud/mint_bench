module top_module (
  input wire        sys_clk,
  input wire        sys_rst_n,
  input wire  [3:0] sys_data_in,
  output wire [3:0] sys_data_out
);

  wire [3:0] internal_data_bus;
  wire        internal_error_status;
  wire [1:0]  internal_diag_vector;

  // Dummy logic to use the signals that will be connected to non-existent ports,
  // preventing unused signal warnings.
  assign internal_error_status = sys_rst_n ^ sys_clk;
  assign internal_diag_vector  = {sys_data_in[0], sys_data_in[1]};

  // Instantiate simple_component with two extra, non-existent port connections.
  // The ports '.status_reg_out' and '.diag_data_vector' do not exist in the 'simple_component' module.
  // This will trigger two STX_VE_690 violations as required by "Total occurrences (from summary): 2".
  simple_component u_component (
    .clk_i              (sys_clk),
    .rst_n_i            (sys_rst_n),
    .data_i             (sys_data_in),
    .data_o             (internal_data_bus),
    .status_reg_out     (internal_error_status),
    .diag_data_vector   (internal_diag_vector)
  );

  // Use the output of the instantiated module to prevent unused signal warnings.
  assign sys_data_out = internal_data_bus;

endmodule
