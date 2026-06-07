module sub_module (
  input wire dummy_in
);
  parameter P = 0; // A simple scalar parameter
  // To resolve 'W240: Input 'dummy_in' declared but not read.' and 
  // 'WarnAnalyzeBBox: Design Unit 'sub_module' has empty definition',
  // the input is assigned to an internal wire, making it 'read' and giving the module internal logic.
  wire dummy_in_local_use = dummy_in;
endmodule
