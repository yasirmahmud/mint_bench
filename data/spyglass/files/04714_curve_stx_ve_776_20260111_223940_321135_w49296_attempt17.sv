module curve_stx_ve_776_20260111_223940_321135_w49296_attempt17 (
  input wire clk,
  output reg output_reg
);

  // STX_VE_776: Always statement not allowed in this scope
  // An 'always' block is a concurrent statement and must be declared at the module level.
  // Placing it inside a function definition is syntactically incorrect.
  function automatic void my_invalid_func;
    always @(posedge clk) begin
      output_reg <= 1'b0;
    end
  endfunction

endmodule
