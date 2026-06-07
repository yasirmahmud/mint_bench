module child_ex2 (input signed [7:0] data_in);
  // Resolves SpyGlass violations:
  // ID 7: "Design Unit 'child_ex2' has empty definition"
  // ID 4: "Input 'data_in[7:0]' declared but not read."
  // An internal register to ensure 'data_in' is read and the module is not empty.
  reg [7:0] data_local_reg;
  always @(*) begin
    data_local_reg = data_in;
  end
endmodule
