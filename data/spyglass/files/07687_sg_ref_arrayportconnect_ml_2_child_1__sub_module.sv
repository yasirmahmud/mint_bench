module sub_module (input wire [7:0] data_in);
  // To resolve W240: Input 'data_in' declared but not read.
  // And potentially WarnAnalyzeBBox: Design Unit 'sub_module' has empty definition.
  // We add internal logic that consumes the input without changing external behavior.
  reg [7:0] dummy_reg; // Declare a local register
  always @(*) begin
    dummy_reg = data_in; // Assign input to consume it
  end
endmodule
