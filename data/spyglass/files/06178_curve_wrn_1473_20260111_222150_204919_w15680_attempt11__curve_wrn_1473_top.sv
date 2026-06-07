module curve_wrn_1473_top ();

  // Instantiate four instances of the submodule.
  my_sub_module u_instance_0 ();
  my_sub_module u_instance_1 ();
  my_sub_module u_instance_2 ();
  my_sub_module u_instance_3 ();

  // Each of these defparam statements attempts to set a parameter that does not exist
  // within 'my_sub_module'. Since the parameters (e.g., UNDEFINED_CONFIG) are not declared
  // in 'my_sub_module', each line will result in an "Unresolved hierarchial reference of defparam"
  // violation (WRN_1473). This creates exactly four occurrences of the target violation.
  defparam u_instance_0.UNDEFINED_CONFIG = 8'hAA;
  defparam u_instance_1.MISSING_SETTING = 16'd1024;
  defparam u_instance_2.INVALID_MODE = 1'b0;
  defparam u_instance_3.UNKNOWN_FACTOR = 32'hDEADBEEF;

endmodule
