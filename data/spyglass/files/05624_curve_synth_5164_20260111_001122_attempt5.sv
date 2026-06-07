module curve_synth_5164_20260111_001122_attempt5 ();

  // This defparam statement attempts to set a parameter on an instance named 'non_existent_inst'.
  // However, 'non_existent_inst' is deliberately NOT declared or instantiated anywhere within this module or its hierarchy.
  // When SpyGlass performs synthesis checks, it will search for the component 'non_existent_inst'
  // to apply the defparam. Since 'non_existent_inst' cannot be found in the design's hierarchy,
  // the tool will trigger SYNTH_5164, indicating that the component was not found and the defparam is ignored for synthesis.
  defparam non_existent_inst.SOME_PARAMETER = 123;

endmodule
