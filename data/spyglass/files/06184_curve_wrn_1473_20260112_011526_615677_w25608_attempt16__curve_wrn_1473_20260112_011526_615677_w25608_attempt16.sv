// This is the top-level module, named according to the filename requirement.
// It instantiates 'peripheral_interface' and attempts to use defparam
// on non-existent parameters within the instantiated module.
module curve_wrn_1473_20260112_011526_615677_w25608_attempt16 (
  input wire sys_clk,
  input wire sys_rst_n,
  input wire [7:0] sys_data_in,
  output wire [7:0] sys_data_out
);

  // Instantiate the sub-component. This instance itself is valid.
  peripheral_interface u_peripheral_inst (
    .clk(sys_clk),
    .rst_n(sys_rst_n),
    .data_in(sys_data_in),
    .data_out(sys_data_out)
  );

  // WRN_1473 violations: Each defparam statement below attempts to set a parameter
  // (e.g., 'CONFIG_REG_A') that does not exist within the 'u_peripheral_inst'
  // instance of the 'peripheral_interface' module. The instance path itself
  // ('u_peripheral_inst') is valid, but the parameter name within it is not found.
  // This precisely triggers the WRN_1473 rule for each line.
  // This creates exactly four occurrences of the target violation.
  defparam u_peripheral_inst.CONFIG_REG_A = 8'hDE;
  defparam u_peripheral_inst.MODE_SELECT_VAL = 2'b10;
  defparam u_peripheral_inst.TIMEOUT_SETTING = 16'd1000;
  defparam u_peripheral_inst.CONTROL_BIT = 1'b1;

endmodule
