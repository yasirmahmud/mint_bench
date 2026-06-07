module sub_module (
  input wire dummy_in
);
  parameter P = 0; // A simple scalar parameter
  // To resolve 'W240: Input 'dummy_in' declared but not read.' and 
  // 'WarnAnalyzeBBox: Design Unit 'sub_module' has empty definition',
  // the input is assigned to an internal register in an always block,
  // making it 'read' and giving the module internal logic.
  // This also resolves 'W528: Variable 'dummy_in_local_use' set but not read.',
  // as the intermediate wire 'dummy_in_local_use' is no longer needed.
  reg dummy_in_sink_reg;
  always @(*) begin
    dummy_in_sink_reg = dummy_in;
  end
endmodule
