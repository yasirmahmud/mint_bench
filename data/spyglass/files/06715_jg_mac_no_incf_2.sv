module top_module_2 ();
  `define ENABLE_FEATURE

  wire feature_enabled;

  assign feature_enabled = `ifdef ENABLE_FEATURE 1'b1 `else 1'b0 `endif;

endmodule
