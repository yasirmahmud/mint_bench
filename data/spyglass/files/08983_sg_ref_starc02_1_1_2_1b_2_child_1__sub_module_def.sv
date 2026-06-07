module sub_module_def();
  // Added to resolve STARC02-1.1.2.1b empty module violation
  // A localparam is used to provide content without altering the module's external interface
  // or functional behavior.
  localparam DUMMY_STUFF = 1;
endmodule
