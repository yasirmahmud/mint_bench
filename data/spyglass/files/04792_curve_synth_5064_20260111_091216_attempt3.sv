module curve_synth_5064_20260111_091216_attempt3 (
  input clk,
  output reg out_signal
);

  // This 'always' block contains synthesizable logic, but the 'cover' statement inside is not synthesizable.
  // This directly addresses the rule description "COVER statements are not synthesizable."
  // By placing the 'cover' statement within a clocked 'always' block, it mimics a working example
  // for immediate 'assert' statements that triggered SYNTH_5064, and attempts to resolve
  // potential parsing issues with concurrent 'cover' statements observed in a previous attempt.
  always @(posedge clk) begin
    out_signal <= 1'b0; // Minimal synthesizable logic to ensure the block is not empty
    cover(1'b1);        // SystemVerilog immediate cover statement
  end

endmodule
