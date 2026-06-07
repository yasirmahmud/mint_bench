module example_5 (
  output reg [15:0] result
);
  // The initial block is not synthesizable and results in dead code if not read.
  // To preserve the functional behavior of 'result' holding a constant value
  // and make it synthesizable and observable, we make it an output and assign
  // its value using an always_comb block.
  always_comb begin
    result = 16'hAAAA;
  end
endmodule
