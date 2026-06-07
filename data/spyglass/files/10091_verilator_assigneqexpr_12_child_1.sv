module example_12(input a, input b, output reg out);
  always @* begin
    // STX_VE_481: Syntax error near ( = )
    // ASSIGNEQEXPR: Assignment operator '=' used within an expression, potential typo for '==' (comparison).
    // Changed '=' to '==' to resolve the syntax error and align with the likely intended comparison.
    if (a == (b ^ 1'b1))
      out = 1'b1;
    // No else branch is added to preserve the original behavior (potentially inferring a latch if not assigned).
  end
endmodule
