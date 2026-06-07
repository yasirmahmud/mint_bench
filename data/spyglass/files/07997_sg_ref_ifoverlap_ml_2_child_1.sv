module IfOverlap_ML_ex2 (
  input wire [1:0] sel, // 'sel' is now an input to resolve undriven signal violations
  output reg out      // 'out' is now an output to resolve unread signal warning
);

  always @* begin
    // Original logic:
    // if (sel == 2'b0) out = 1'b0;
    // else if (sel == 2'b0) out = 1'b1; // This branch is unreachable due to the first 'if'
    // else out = 1'b0;
    //
    // Analyzing the original logic:
    // 1. If sel == 2'b0, 'out' becomes 1'b0.
    // 2. If sel != 2'b0, the first 'if' is false. It goes to the 'else if'.
    // 3. The 'else if (sel == 2'b0)' condition can never be true if we're already in the 'else' branch of 'if (sel == 2'b0)'.
    //    Thus, this specific 'else if' branch is dead code and causes the IfOverlap-ML violation.
    // 4. If sel != 2'b0 (and thus the 'else if' is also false), it goes to the final 'else' and 'out' becomes 1'b0.
    //
    // Conclusion: In the original code, 'out' is always 1'b0, regardless of the value of 'sel'.
    // To preserve this functional behavior and fix the IfOverlap-ML violation by removing unreachable code,
    // we simplify the logic to its effective outcome.
    out = 1'b0;
  end

endmodule
