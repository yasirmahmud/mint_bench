module param_source_module #(
  parameter TEST_VALUE = 10
) ();
  // This module's only purpose is to provide a parameter for hierarchical reference.
  // No ports or internal logic are needed as only its parameter is referenced.
endmodule
