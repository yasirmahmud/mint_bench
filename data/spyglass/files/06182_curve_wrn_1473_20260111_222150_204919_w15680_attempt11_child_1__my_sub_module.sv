// Define a simple submodule.
// A dummy signal has been added to prevent "Design Unit 'my_sub_module' has empty definition" (WarnAnalyzeBBox) violations.
module my_sub_module ();
  // No parameters are defined here.
  wire dummy_signal; // Dummy signal to prevent empty module warning.
endmodule
