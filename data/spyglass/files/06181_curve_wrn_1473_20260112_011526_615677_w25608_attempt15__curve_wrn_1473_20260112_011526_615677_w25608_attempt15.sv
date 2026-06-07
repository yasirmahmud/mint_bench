// This is the top-level module, named according to the filename requirement.
// It instantiates 'data_processor' and attempts to use defparam on non-existent parameters
// within the instantiated module.
module curve_wrn_1473_20260112_011526_615677_w25608_attempt15 (
  input wire main_clk,
  input wire main_reset_n,
  input wire main_data_in,
  output wire main_data_out
);

  // Instantiate the sub-component.
  data_processor u_core_logic (
    .clk_i(main_clk),
    .rst_n_i(main_reset_n),
    .data_i(main_data_in),
    .data_o(main_data_out)
  );

  // WRN_1473 violations: Each defparam statement attempts to set a parameter
  // (e.g., 'PARAM_A_MISSING') that does not exist within the 'u_core_logic'
  // instance of the 'data_processor' module. The instance path itself ('u_core_logic')
  // is valid, but the parameter within it is not found. This precisely triggers
  // the WRN_1473 rule for each line without introducing other violations.
  // This creates exactly four occurrences of the target violation.
  defparam u_core_logic.PARAM_A_MISSING = 8'hC1;
  defparam u_core_logic.PARAM_B_INVALID = 16'd2048;
  defparam u_core_logic.PARAM_C_UNRESOLVED = 1'b0;
  defparam u_core_logic.PARAM_D_NONEXISTENT = 32'hFEEDCAFE;

endmodule
