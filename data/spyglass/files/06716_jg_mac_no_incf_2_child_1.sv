module top_module_2 ();
  `define ENABLE_FEATURE

  wire feature_enabled;
  wire dummy_read_feature_enabled; // Added to resolve W528 violation

  assign feature_enabled = `ifdef ENABLE_FEATURE 1'b1 `else 1'b0 `endif;

  // Consume 'feature_enabled' to resolve the 'set but not read' warning
  assign dummy_read_feature_enabled = feature_enabled;

endmodule
