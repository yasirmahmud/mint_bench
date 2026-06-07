module curve_wrn_1473_top ();

  // Instantiate four instances of the submodule.
  my_sub_module u_instance_0 ();
  my_sub_module u_instance_1 ();
  my_sub_module u_instance_2 ();
  my_sub_module u_instance_3 ();

  // The original defparam statements were causing "Unresolved hierarchial reference of defparam"
  // (WRN_1473) and "Component (u_instance_X) not found. Ignoring DEFPARAM" (SYNTH_5164)
  // violations because the parameters did not exist in 'my_sub_module'.
  // These statements have been removed to resolve these violations, as they had no functional effect.

endmodule
