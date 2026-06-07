module curve_wrn_1473_20260111_005828_attempt2;
  // This defparam statement targets 'sub_inst.PARAM'.
  // The module instance 'sub_inst' is neither declared nor instantiated in this module,
  // making its hierarchical reference entirely unresolved.
  // This structure is specifically designed to trigger exactly one WRN_1473 violation.
  defparam sub_inst.PARAM = 1'b0;
endmodule
