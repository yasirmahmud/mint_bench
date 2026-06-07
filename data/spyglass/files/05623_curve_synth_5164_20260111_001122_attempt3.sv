module curve_synth_5164_20260111_001122_attempt3 ();

  // This defparam targets an instance named 'sub_inst'.
  // Crucially, 'sub_inst' is NOT instantiated anywhere in this module,
  // and its corresponding module definition is also absent.
  // SpyGlass will attempt to process this defparam, but since the target component
  // ('sub_inst') cannot be found (neither its instance nor its module definition),
  // it will trigger SYNTH_5164 and ignore the defparam.
  defparam sub_inst.MY_PARAM = 10;

endmodule
