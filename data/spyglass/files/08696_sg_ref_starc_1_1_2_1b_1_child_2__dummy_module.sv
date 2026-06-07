module dummy_module();
  // SpyGlass STARC-1.1.2.1b fix: Added a dummy synthesizable statement to avoid empty module definition and initial block warnings.
  wire sg_dummy_wire;
  assign sg_dummy_wire = 1'b0;
endmodule
