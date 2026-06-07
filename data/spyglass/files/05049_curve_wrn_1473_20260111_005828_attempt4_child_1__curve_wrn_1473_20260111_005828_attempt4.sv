module curve_wrn_1473_20260111_005828_attempt4;
  // Instantiate the sub-module multiple times.
  sub_module inst_a ();
  sub_module inst_b ();
  sub_module inst_c ();
  sub_module inst_d ();

  // These defparam statements attempt to modify a localparam. 
  // While 'P_local_unoverridable' exists, it cannot be overridden by defparam 
  // because it's a localparam, not a parameter.
  // This is expected to trigger WRN_1473 for each statement as an 
  // "unresolved hierarchial reference" in the context of defparam's intended use.
  // It should NOT trigger SYNTH_5164 because the localparam itself IS found
  // (the component exists, but the operation is invalid for it).
  defparam inst_a.P_local_unoverridable = 11;
  defparam inst_b.P_local_unoverridable = 22;
  defparam inst_c.P_local_unoverridable = 33;
  defparam inst_d.P_local_unoverridable = 44;

  // Add a simple declaration and initial block to ensure the top module is not empty
  reg dummy_top_signal;
  initial begin
    dummy_top_signal = 1'b0;
  end

endmodule
